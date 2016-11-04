From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Fri, 04 Nov 2016 19:21:30 +0900
Subject: [PATCH 10/13] ARM: dts: exynos: replace to "max-frequecy" instead
 of "clock-freq-min-max"
In-Reply-To: <20161103184112.GB11071@kozik-lap>
References: <20161103062135.10697-1-jh80.chung@samsung.com>
 <20161103062135.10697-11-jh80.chung@samsung.com>
 <CGME20161103184120epcas1p3e51865aa2ea7b6073bcb72f5cba5772f@epcas1p3.samsung.com>
 <20161103184112.GB11071@kozik-lap>
Message-ID: <ecf4fac2-0ab7-d4c4-69e3-d498ee5b601c@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/2016 03:41 AM, Krzysztof Kozlowski wrote:
> On Thu, Nov 03, 2016 at 03:21:32PM +0900, Jaehoon Chung wrote:
>> In drivers/mmc/core/host.c, there is "max-frequency" property.
>> It should be same behavior. So Use the "max-frequency" instead of
>> "clock-freq-min-max".
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos3250-artik5-eval.dts | 2 +-
>>  arch/arm/boot/dts/exynos3250-artik5.dtsi     | 2 +-
>>  arch/arm/boot/dts/exynos3250-monk.dts        | 2 +-
>>  arch/arm/boot/dts/exynos3250-rinato.dts      | 2 +-
>>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> This looks totally independent to rest of patches so it can be applied
> separately without any functional impact (except lack of minimum
> frequency). Is that correct?

You're right. I will split the patches. And will resend.
Thanks!

Best Regards,
Jaehoon Chung

> 
> Best regards,
> Krzysztof
> 
> 
> 
> 
