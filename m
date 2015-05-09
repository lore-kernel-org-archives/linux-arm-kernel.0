From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sat, 9 May 2015 09:53:29 +0900
Subject: ARM: EXYNOS: dts: Improvements for 4.2
In-Reply-To: <1430873981-22902-1-git-send-email-k.kozlowski@samsung.com>
References: <1430873981-22902-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CAJKOXPeSbL94thCLq2mLTBfr3KLuH4y4S=HyS-phkHuanae15A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-06 9:59 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
> Dear Kukjin,
>
> I gathered various improvements for upcoming 4.2 merge window.
> Description along with a tag.
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
>   https://github.com/krzk/linux.git tags/samsung-dt-for-next-4.2
>
> for you to fetch changes up to 98155ec454a40212434c83c1388c420a61d62854:
>
>   ARM: dts: exynos4: add nodes for jpeg codec (2015-05-05 19:19:18 +0900)
>
> ----------------------------------------------------------------
> Device Tree improvements for Exynos based boards:
> 1. Fix PMIC's RTC alarm on Arndale Octa (S2MPS11 PMIC) and SMDK5250 (MAXIM77686
>    PMIC).
> 2. Fix suspend on Peach Pit Chromebooks prevented by Marvell mwifiex
>    driver.
> 3. Fix hang on Odroid XU3 on MMC card detect.
> 4. Enable the S3C RTC (the clock present on SoC) on various Exynos boards.
> 5. Minor improvements to S3C RTC driver.
> 6. Add nodes for JPEG codec on Exynos4.
>
> ----------------------------------------------------------------
> Andrzej Hajda (1):
>       ARM: dts: exynos5422-odroidxu3: add mmc detect gpio
>
> Javier Martinez Canillas (2):
>       ARM: dts: Make DP a consumer of DISP1 power domain on Exynos5420
>       ARM: dts: Add keep-power-in-suspend to WiFi SDIO node for Peach Boards
>
> Krzysztof Kozlowski (5):
>       ARM: dts: Fix pinctrl settings for S2MPS11 RTC alarm IRQ on Arndale Octa
>       ARM: dts: s3c-rtc: Use s3c6410-rtc instead of exynos3250-rtc
>       ARM: dts: Use define for s3c-rtc clock id
>       ARM: dts: Use define for s3c-rtc clock id
>       ARM: dts: Enable S3C RTC on Trats2 and Arndale Octa
>
> Marek Szyprowski (1):
>       ARM: dts: exynos4: add nodes for jpeg codec
>
> Markus Reichl (2):
>       ARM: dts: Add bindings for 32kHz clocks from s2mps11
>       ARM: dts: exynos5422-odroidxu3: add 'rtc_src' clock to rtc node
>
> Yadwinder Singh Brar (1):
>       ARM: dts: Add missing irq pinctrl for max77686 on smdk5250


Dear Kukjin,

Gentle reminder, it seems this one was missed.
Could you apply these patches as well? Above you will find description
of the pull request.

Best regards,
Krzysztof
