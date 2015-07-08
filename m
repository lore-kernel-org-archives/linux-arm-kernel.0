From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 09 Jul 2015 08:53:49 +0900
Subject: [PATCH 2/4] ARM: dts: Extend exynos5250-pinctrl nodes using labels
 instead of paths
In-Reply-To: <559D2E39.6060602@osg.samsung.com>
References: <1436333790-18219-1-git-send-email-javier@osg.samsung.com>
 <1436333790-18219-3-git-send-email-javier@osg.samsung.com>
 <559CDF66.6080609@samsung.com> <559D2E39.6060602@osg.samsung.com>
Message-ID: <559DB80D.20702@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.07.2015 23:05, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 07/08/2015 01:29 AM, Krzysztof Kozlowski wrote:
>> On 08.07.2015 14:36, Javier Martinez Canillas wrote:
>>> A previously defined Device Tree node, can be extended either by defining
>>> a node using the same full path or by creating a label for the node and
>>> referencing to it.
>>>
>>> Using full paths is more error prone since if there was a typo error, a
>>> new node will be created instead of extending the node as it was desired.
>>> This will lead to run-time errors that could be hard to detect.
>>>
>>> A misstyped label on the other hand, will cause a dtc compile error which
>>
>> s/misstyped/mistyped/
>>
> 
> sigh, it's so ironic that I mistyped that.
> 
> Do you want me to re-post the whole series with the typo fixed or you /
> Kukjin would fix in both patches when applying?

I'll fix it when applying to my tree. As for Kukjin, it depends whether
he will pick it up from LKML or from me.

Best regards,
Krzysztof
