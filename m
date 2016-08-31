From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 31 Aug 2016 09:18:03 +0200
Subject: [PATCH v4] ARM: dts: exynos: Enable HDMI for Arndale Octa board
In-Reply-To: <b6337c5b-90a3-21a3-a0b9-a5c4809e5ee1@samsung.com>
References: <20160831060847.1350-1-woogyom.kim@gmail.com>
 <b6337c5b-90a3-21a3-a0b9-a5c4809e5ee1@samsung.com>
Message-ID: <28fd9360-47b9-5e96-cec3-dc01a47e7071@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/31/2016 08:54 AM, Andrzej Hajda wrote:
> On 08/31/2016 08:08 AM, Milo Kim wrote:
>> * GPIO for HDMI hot plug detect
>>   GPX3_7 is used. The HPD awareness is done when the GPIO is active high.
>>
>> * Enable HDMI block in Exynos5420
>>   HDMI VDD and PLL consume 1.0V LDO6 (PVDD_ANAIP_1V0) and HDMI oscillator
>>   requires 1.8V LDO7 (PVDD_ANAIP_1V8).
>>
>> * Support HDMI display data channel
>>   I2C #2 is assigned for the HDMI DDC. It enables the EDID access.
>>
>> Cc: Kukjin Kim <kgene@kernel.org>
>> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: linux-samsung-soc at vger.kernel.org
>> Cc: linux-kernel at vger.kernel.org
>> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
> 
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

Thanks, applied with Andrzej's review.

Best regards,
Krzysztof
