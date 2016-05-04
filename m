From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 04 May 2016 15:06:45 +0200
Subject: [PATCH v3 3/3] ARM: dts: exynos: Lower SD card interface voltage
 to 2.8 V on Odroid X/X2/U3
In-Reply-To: <764fb4d7-873f-0e59-446b-e9652151512d@osg.samsung.com>
References: <1462365840-27406-1-git-send-email-k.kozlowski@samsung.com>
 <1462365840-27406-3-git-send-email-k.kozlowski@samsung.com>
 <764fb4d7-873f-0e59-446b-e9652151512d@osg.samsung.com>
Message-ID: <5729F3E5.4010702@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/2016 02:51 PM, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 05/04/2016 08:44 AM, Krzysztof Kozlowski wrote:
>> Odroid X/X2/U3 schematics say that SD card vmmc regulator
>> (LDO21/TFLASH) operates on 2.8 V. Mainline U-Boot uses that value as
>> well and 2.8 V is common on Exynos-based boards. Additionally use some
>> descriptive name for this regulator.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>
>> ---
>> Changes since v2:
>> 1. Add Javier's tag.
>>
> 
> It's missing though :)
> 
> Adding the tag again so it can be picked by patchwork:
> 
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

D'oh!

Thanks for spotting,
Krzysztof
