using UnityEngine;
using System.Collections;
using DG.Tweening;
[AddComponentMenu("Camera-Control/Mouse Orbit with zoom")]
public class MouseOrbitImproved : MonoBehaviour {
	public Transform target;
	public float distance = 5.0f;
	public float xSpeed = 120.0f;
	public float ySpeed = 120.0f;

	public float yMinLimit = -20f;
	public float yMaxLimit = 80f;

	public float distanceMin = .5f;
	public float distanceMax = 15f;

	private Rigidbody rigidbodycam;

	public float x = 0.0f;
	public float y = 0.0f;

	Vector3 camoripos, camorirot, targetoripos;
	bool anim = false;
	// Use this for initialization
	void Start () 
	{
		Vector3 angles = transform.eulerAngles;
		x = angles.y;
		y = angles.x;

		rigidbodycam = GetComponent<Rigidbody>();

		// Make the rigid body not change rotation
		if (rigidbodycam != null)
		{
			rigidbodycam.freezeRotation = true;
		}

		camoripos = this.transform.position;
		camorirot = this.transform.eulerAngles;
		targetoripos = target.position;

    }

    IEnumerator Lerp(Vector3 v3,float time = 2)
    {
		anim = true;
		Vector3 temp = new Vector3(x,y,distance);
		for (float i =0;i< time; i+=Time.deltaTime)
		{
            x = easeInOutQuad(temp.x, v3.x, i / time);
            y = easeInOutQuad(temp.y, v3.y, i / time);
            distance = easeInOutQuad(temp.z, v3.z, i / time);
            //x = Mathf.Lerp(temp.x, v3.x, i/time);
            //y = Mathf.Lerp(temp.y, v3.y, i/time);
            //distance = Mathf.Lerp(temp.z, v3.z, i/time);
            yield return null;
		}
		
		x = v3.x;
		y = v3.y;
		distance = v3.z;
		anim = false;
	}

	private float easeInOutQuad(float start, float end, float value)
	{
		value /= .5f;
		end -= start;
		if (value < 1) return end * 0.5f * value * value + start;
		value--;
		return -end * 0.5f * (value * (value - 2) - 1) + start;
	}

    public void Reset()
	{
		this.transform.position = camoripos;
		this.transform.eulerAngles = camorirot;
		Vector3 angles = transform.eulerAngles;
		x = angles.y;
		y = angles.x;
		target.position = targetoripos;
		distance = 17;
	}
    Vector3 mousepos;
    Vector2 touchpos;
	public bool cancontrol;
	public void SetControl(bool b)
    {
		cancontrol = b;

	}
	private Touch oldTouch1; //上次触摸点1
	private Touch oldTouch2; //上次触摸点2
	void LateUpdate () 
	{
		if (cancontrol && !anim)
        {
			if (Input.touchCount > 0)
			{
				if (Input.touchCount == 1)
				{
					if (Input.GetTouch(0).phase == TouchPhase.Began)
					{
						touchpos = Input.GetTouch(0).position;
					}
					if (Input.GetTouch(0).phase == TouchPhase.Moved)
					{
						x += (Input.GetTouch(0).position - touchpos).x * 1 * Time.deltaTime;
						y -= (Input.GetTouch(0).position - touchpos).y * 1 * Time.deltaTime;

						y = ClampAngle(y, yMinLimit, yMaxLimit);
						touchpos = Input.GetTouch(0).position;
					}
				}
				if (Input.touchCount > 1)
				{
					//多点触摸、实现缩放
					Touch newTouch1 = Input.GetTouch(0);//新触摸点1
					Touch newTouch2 = Input.GetTouch(1);//新触摸点1
														//第二点刚接触屏幕，只做记录，不做处理
					if (newTouch2.phase == TouchPhase.Began)
					{
						oldTouch1 = newTouch1;
						oldTouch2 = newTouch2;
						return;
					}
					//计算旧的两点和新的两点之间的距离，变大就要放大模型，变小就要缩小模型
					float oldDistance = Vector2.Distance(oldTouch1.position, oldTouch2.position);
					float newDistance = Vector2.Distance(newTouch1.position, newTouch2.position);
					float offSet = newDistance - oldDistance;
					//放大因子，一个像素按0.01倍来算
					float scaleFactor = offSet;
					distance -= scaleFactor;
					distance = Mathf.Clamp(distance, distanceMin, distanceMax);
					//记录最新的触摸点，供下次使用
					oldTouch1 = newTouch1;
					oldTouch2 = newTouch2;

				}
			}
			else
			{
				if (Input.GetMouseButton(0))
				{
					x += Input.GetAxis("Mouse X") * xSpeed * Time.deltaTime;
					y -= Input.GetAxis("Mouse Y") * ySpeed * Time.deltaTime;

					y = ClampAngle(y, yMinLimit, yMaxLimit);
				}
				else
					x += Time.deltaTime;
			}
			
			

			//if (Input.GetMouseButtonDown(1))
			//	mousepos = Input.mousePosition;
			//if (Input.GetMouseButton(1))
			//{
			//	target.Translate(Vector3.right * (Input.mousePosition.x - mousepos.x) * 0.01f);
			//	target.Translate(Vector3.forward * (Input.mousePosition.y - mousepos.y) * 0.01f);
			//	mousepos = Input.mousePosition;
			//}
		}
		

		if(target)
		{
			x = x % 360;
			y = y % 360;
			Quaternion rotation = Quaternion.Euler(y, x, 0);

			distance = Mathf.Clamp(distance - Input.GetAxis("Mouse ScrollWheel")*100, distanceMin, distanceMax);

			Vector3 negDistance = new Vector3(0.0f, 0.0f, -distance);
			Vector3 position = rotation * negDistance + target.position;

			transform.rotation = rotation;
			transform.position = position;
		}
	}

	public static float ClampAngle(float angle, float min, float max)
	{
		if (angle < -360F)
			angle += 360F;
		if (angle > 360F)
			angle -= 360F;
		return Mathf.Clamp(angle, min, max);
	}
}