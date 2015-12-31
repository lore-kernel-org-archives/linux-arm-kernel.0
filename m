From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 31 Dec 2015 17:33 +0100
Subject: [GIT PULL] ARM: EXYNOS: dts: DeviceTree for v4.5, 2nd try
In-Reply-To: <1451368997-16809-1-git-send-email-k.kozlowski@samsung.com>
References: <20151222045221.GH30172@localhost>
 <1451368997-16809-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <4826405.S0bHR9ucyK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 December 2015 15:03:17 Krzysztof Kozlowski wrote:
> Samsung DeviceTree updates and improvements for 4.5
> 1. eMMC/SDIO minor fixes usage of bindings on Snow and Peach
>    Chromebooks.
> 2. Remove FIMD from Odroid XU3-family because on XU3 it cannot be used
>    yet and on XU3-Lite and XU4 it is not supported.
> 3. Remove deprecated since June 2013 samsung,exynos5-hdmi.
> 4. Add support for Pseudo Random Generator on Exynos4 (Trats2 for now).
>    This depends on new SSS clock.
> 5. Add rotator nodes for Exynos4 and Exynos5.
> 6. Switch DWC3_1 on Odroid XU3 and XU3-Lite to peripheral mode because
>    now it cannot be used as OTG.
> 7. Cleanup the G2D usage on Exynos4 and add it to a proper domain
>    in case of Exynos4210.
> 8. Put MDMA1 in proper domain on Exynos4210 as well.
> 9. Minor cleanups.
> 

Pulled into next/dt, thanks!

	Arnd
