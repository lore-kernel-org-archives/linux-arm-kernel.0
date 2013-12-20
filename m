From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 21 Dec 2013 08:37:16 +0900
Subject: [PATCH 3/3] ARM: dts: Rename Exynos5250 ChromeOS common file
 to have exynos prefix
In-Reply-To: <52B4CE30.6030205@samsung.com>
References: <1385381710-5212-1-git-send-email-broonie@kernel.org>
 <1385381710-5212-3-git-send-email-broonie@kernel.org>
 <52B4CE30.6030205@samsung.com>
Message-ID: <52B4D4AC.10109@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/21/13 08:09, Kukjin Kim wrote:
> On 11/25/13 21:15, Mark Brown wrote:
>> From: Mark Brown<broonie@linaro.org>
>>
>> Make it easier to notice the common file for ChromeOS devices based on
>> the Exynos5250 by giving it the exynos5250 prefix that the boards have.
>>
>> Signed-off-by: Mark Brown<broonie@linaro.org>
>> Acked-by: Tomasz Figa<t.figa@samsung.com>
>> ---
>> arch/arm/boot/dts/{cros5250-common.dtsi =>
>> exynos5250-cros-common.dtsi} | 0
>> arch/arm/boot/dts/exynos5250-snow.dts | 2 +-
>> 2 files changed, 1 insertion(+), 1 deletion(-)
>> rename arch/arm/boot/dts/{cros5250-common.dtsi =>
>> exynos5250-cros-common.dtsi} (100%)
>>
>> diff --git a/arch/arm/boot/dts/cros5250-common.dtsi
>> b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
>> similarity index 100%
>> rename from arch/arm/boot/dts/cros5250-common.dtsi
>> rename to arch/arm/boot/dts/exynos5250-cros-common.dtsi
>> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts
>> b/arch/arm/boot/dts/exynos5250-snow.dts
>> index fd711e245e8d..7e2669c6f7f5 100644
>> --- a/arch/arm/boot/dts/exynos5250-snow.dts
>> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
>> @@ -10,7 +10,7 @@
>>
>> /dts-v1/;
>> #include "exynos5250.dtsi"
>> -#include "cros5250-common.dtsi"
>> +#include "exynos5250-cros-common.dtsi"
>>
>> / {
>> model = "Google Snow";
>
> + Doug and Olof.
>
Oops, I missed. Again +

> Doug and Olof,
>
> I need your ack on this. How do you think?
>

One more, I've applied Mark's 1/3 and 2/3 patches.

Thanks,
Kukjin
