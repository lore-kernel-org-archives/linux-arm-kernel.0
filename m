From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 18 Jun 2013 00:10:50 +0900
Subject: [PATCH V2] ARM: dts: Enable RTC node for Arndale
In-Reply-To: <1371442179-23597-1-git-send-email-tushar.behera@linaro.org>
References: <CAHbNUh2byimQ_ep0j9XkUjRFaU3K6YZE_ANcch5UhP4QsuZxPw@mail.gmail.com>
 <1371442179-23597-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <51BF26FA.9010807@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/17/13 13:09, Tushar Behera wrote:
> The issues reported in commit 522ccdb6fd0e ("ARM: dts: Disable the RTC
> by default on exynos5") are no longer reproduced on EXYNOS5250 based
> Arndale board. Hence re-enabling RTC support for Arndale board.
>
> This is helpful for testing S2R on Arndale board.
>
> Signed-off-by: Tushar Behera<tushar.behera@linaro.org>
> ---
> Changes for V2:
> * RTC node is enabled only for Arndale board. Earlier it was enabled
> in exynos5250.dtsi.
>
>   arch/arm/boot/dts/exynos5250-arndale.dts |    4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
> index 02cfc76..b38080a 100644
> --- a/arch/arm/boot/dts/exynos5250-arndale.dts
> +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
> @@ -449,4 +449,8 @@
>   			clock-frequency =<24000000>;
>   		};
>   	};
> +
> +	rtc {
> +		status = "okay";
> +	};
>   };

Applied, thanks.

- Kukjin
