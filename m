From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 10 Dec 2013 06:07:14 +0900
Subject: [PATCH 1/3] ARM: dts: Leave Exynos5250 SPI controller disabled
 by default
In-Reply-To: <5026211.5mW8H3pyKS@amdc1227>
References: <1385381710-5212-1-git-send-email-broonie@kernel.org>
 <5026211.5mW8H3pyKS@amdc1227>
Message-ID: <52A63102.5040708@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/13 00:23, Tomasz Figa wrote:
> Hi Kukjin,
>
Hi,

> On Monday 25 of November 2013 12:15:08 Mark Brown wrote:
>> From: Mark Brown<broonie@linaro.org>
>>
>> Rather than requiring each board to explicitly disable the SPI controllers
>> it is not using instead require boards to enable those that they are using.
>> This is less work overall since normally at most one of the controllers is
>> in use and avoids issues caused by inappropriate pinmuxing.
>>
>> Signed-off-by: Mark Brown<broonie@linaro.org>
>> Acked-by: Tomasz Figa<t.figa@samsung.com>
>> ---
>>   arch/arm/boot/dts/cros5250-common.dtsi    |  9 +--------
>>   arch/arm/boot/dts/exynos5250-arndale.dts  | 12 ------------
>>   arch/arm/boot/dts/exynos5250-smdk5250.dts |  6 ++----
>>   arch/arm/boot/dts/exynos5250.dtsi         |  3 +++
>>   4 files changed, 6 insertions(+), 24 deletions(-)
>
> Seems like you have missed this series. Could you apply it?
>
Yeah, thanks for your gentle reminder.

+ Doug and Olof

BTW, Doug and Olof, are you OK with changing the name of cros5250-common 
DT file? Basically, I agree with Mark's patch.

- Kukjin
