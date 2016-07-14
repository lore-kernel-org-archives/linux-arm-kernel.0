From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Jul 2016 14:44:04 +0200
Subject: [PATCH] arm64: dts: Fix RTC by providing rtc_src clock
In-Reply-To: <1468222458-4265-2-git-send-email-k.kozlowski@samsung.com>
References: <1468222458-4265-1-git-send-email-k.kozlowski@samsung.com>
 <1468222458-4265-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <4469058.ECgkgrt5Se@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 11, 2016 9:34:18 AM CEST Krzysztof Kozlowski wrote:
> From: Alim Akhtar <alim.akhtar@samsung.com>
> 
> Add RTC source clock as Exynos7 needs source (32.768KHz) clock
> for RTC block. Without this currently S3C RTC driver probe is broken
> on this SoC.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 

Applied to fixes, thanks!

	Arnd
