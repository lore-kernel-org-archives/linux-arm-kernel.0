From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 31 Jul 2015 11:37:41 +0200
Subject: [PATCH] PM / devfreq: event: Remove incorrect property in
 exynos-ppmu DT binding
In-Reply-To: <55B0A616.2070608@osg.samsung.com>
References: <1436770732-9430-1-git-send-email-javier@osg.samsung.com>
 <55B0A376.2080906@samsung.com> <55B0A616.2070608@osg.samsung.com>
Message-ID: <55BB41E5.8010209@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Myungjoo,

On 07/23/2015 10:30 AM, Javier Martinez Canillas wrote:
> Hello Chanwoo,
> 
> On 07/23/2015 10:19 AM, Chanwoo Choi wrote:
>> Hi Javier,
>>
>> On 07/13/2015 03:58 PM, Javier Martinez Canillas wrote:
>>> The exynos-ppmu driver is only a clock consumer and not a clock
>>> provider but its Device Tree binding listed #clock-cells as an
>>> optional property.
>>>
>>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>>
>>> ---
>>>
>>> Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt | 1
>>> - 1 file changed, 1 deletion(-)
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
>>> b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt 
>>> index b54bf3a2ff57..aed486692880 100644 ---
>>> a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt 
>>> +++
>>> b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt 
>>> @@ -17,7 +17,6 @@ Required properties: Optional properties: -
>>> clock-names : the name of clock used by the PPMU, "ppmu" - clocks :
>>> phandles for clock specified in "clock-names" property --
>>> #clock-cells: should be 1.
>>>
>>> Example1 : PPMU nodes in exynos3250.dtsi are listed below.
>>>
>>>
>>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>
>> + Devfreq maintainer (Myungjoo Ham)
> 
> Thanks for the review and for cc'ing Myungjoo. The get_maintainer.pl script
> didn't tell me that so I think Documentation/devicetree/bindings/devfreq/
> sub-dir should be added to the DEVICE FREQUENCY (DEVFREQ) entry in the
> MAINTAINERS file.
> 
>> I think that this patch will be more appropriate on devfreq git tree 
>> than linux-samsung git tree.
>>
> 
> Agreed.
> 

Any comments about this patch?

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
