using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using UnityEngine;

public static class Tools
{
    
    public static T FindComponent<T>(this Transform trans, string name)
    {
        Transform child = trans.Find(name);
        if (child != null)
            return child.GetComponent<T>();
        else
            return default(T);
    }

    public static Transform[] FindChildrenWithName(this Transform trans, string name)
    {
        List<Transform> listtrans = new List<Transform>();
        Transform[] child = trans.GetComponentsInChildren<Transform>(true);
        foreach (Transform t in child)
        {
            if (t.name == name)
            {
                listtrans.Add(t);
            }
        }
        return listtrans.ToArray();
    }

    public static Transform FindChildWithName(this Transform trans, string name, bool hide = true)
    {
        Transform[] child = trans.GetComponentsInChildren<Transform>(hide);
        foreach (Transform t in child)
        {
            if (t.name == name)
                return t;
        }
        return null;
    }

    public static T FindComponentWithName<T>(this Transform trans, string name)
    {
        T[] child = trans.GetComponentsInChildren<T>(true);
        foreach (T t in child)
        {
            if ((t as UnityEngine.Object).name == name)
                return t;
        }
        return default(T);
    }

    public static void SetLayer(this GameObject go, int i)
    {
        Transform[] t = go.GetComponentsInChildren<Transform>(true);
        foreach (Transform tt in t)
            tt.gameObject.layer = i;
    }

    public static void HideChildren(this Transform go, params string[] s)
    {
        for (int i = 0; i < go.childCount; i++)
        {
            bool b = false;
            GameObject g = go.GetChild(i).gameObject;
            foreach (string ss in s)
                if (ss == g.name)
                    b = true;

            if (!b)
                g.SetActive(false);
        }
    }

    public static Color HexToColor(string hex)
    {
        hex = hex.Replace("0x", string.Empty);
        hex = hex.Replace("#", string.Empty);
        byte a = byte.MaxValue;
        byte r = byte.Parse(hex.Substring(0, 2), NumberStyles.HexNumber);
        byte g = byte.Parse(hex.Substring(2, 2), NumberStyles.HexNumber);
        byte b = byte.Parse(hex.Substring(4, 2), NumberStyles.HexNumber);
        if (hex.Length == 8)
        {
            a = byte.Parse(hex.Substring(6, 2), NumberStyles.HexNumber);
        }
        return new Color32(r, g, b, a);
    }
}
