From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Wed, 11 May 2016 08:18:28 -0400
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Enable Exynos MFC driver as
 module
In-Reply-To: <573322C7.40203@samsung.com>
References: <1462914448-24480-1-git-send-email-javier@osg.samsung.com>
 <1462914448-24480-2-git-send-email-javier@osg.samsung.com>
 <5732D0BF.3020207@samsung.com>
 <d36b1ca3-413a-8a19-ad96-0775593e4337@osg.samsung.com>
 <573322C7.40203@samsung.com>
Message-ID: <0623124f-a588-e8ca-2048-c3f7e1ff6506@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/11/2016 08:17 AM, Krzysztof Kozlowski wrote:
> On 05/11/2016 02:14 PM, Javier Martinez Canillas wrote:
>> Hello Krzysztof,
>>
>> On 05/11/2016 02:27 AM, Krzysztof Kozlowski wrote:
>>> On 05/10/2016 11:07 PM, Javier Martinez Canillas wrote:
>>>> Exynos SoCs have a Multi Format Video Hardware Codec (MFC) IP block that
>>>> can be used to {en,de}code video streams by hardware. Enable support for
>>>> its driver as a module so the MFC can be tested.
>>>>
>>>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>>>
>>>> ---
>>>>
>>>> This patch depends on https://patchwork.kernel.org/patch/8970711/
>>>>
>>>>  arch/arm/configs/multi_v7_defconfig | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>
>>>
>>> Both patches look good but only exynos_defconfig ended in Patchwork.
>>> This one did not... because you forgot to Cc the samsung-soc list.
>>>
>>
>> Sigh, this time I used the cc list suggested by get_maintainers.pl and
>> forgot to double check if was complete. I'll resend and cc samsung-soc.
> 
> No need. I found it on arm-kernel patchwork and I will apply it from there.
>

Great, thanks a lot for your help.
 
> Best regards,
> Krzysztof
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
