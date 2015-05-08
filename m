From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 09 May 2015 03:33:33 +0900
Subject: ARM: EXYNOS: dts: DTS fixes for 4.1
In-Reply-To: <1430873903-22787-1-git-send-email-k.kozlowski@samsung.com>
References: <1430873903-22787-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <554D017D.4050201@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/15 09:58, Krzysztof Kozlowski wrote:
> Dear Kukjin,
> 
> This groups important fix for current RC cycle, well tested and
> present on mailing list for some time.
> 
> Best regards,
> Krzysztof
> 
> ----------------------------------------------------------------
> The following changes since commit 5ebe6afaf0057ac3eaeb98defd5456894b446d22:
> 
>   Linux 4.1-rc2 (2015-05-03 19:22:23 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/krzk/linux.git tags/samsung-dt-fixes-4.1
> 
> for you to fetch changes up to d52ccd7b731f881df051331c92a5c54a94adf516:
> 
>   ARM: dts: Make DP a consumer of DISP1 power domain on Exynos5420 (2015-05-05 19:15:57 +0900)
> 
> ----------------------------------------------------------------
> Fix for imprecise external abort on Exynos5420 boards introduced after adding
> display power domain in DTS.
> 
> ----------------------------------------------------------------
> Javier Martinez Canillas (1):
>       ARM: dts: Make DP a consumer of DISP1 power domain on Exynos5420
> 
>  arch/arm/boot/dts/exynos5420.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> --

I've applied it directly. Thanks for your gentle reminder.

- Kukjin
