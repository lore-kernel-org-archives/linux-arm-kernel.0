From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Jun 2015 17:06:21 +0200
Subject: [GIT PULL] ARM: EXYNOS: Fix for 4.1, 4th
In-Reply-To: <1433120217-26814-1-git-send-email-k.kozlowski@samsung.com>
References: <1433120217-26814-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1716391.lQMtOGPqf7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 June 2015 09:56:57 Krzysztof Kozlowski wrote:
> Fix for Exynos3250 RTC wake-up interrupts after converting PMU
> wakeup to stacked domains. This allows waking up the device from
> suspend to RAM using S3C RTC driver (the RTC on SoC).
> 
> The patch should be applied some time ago, unfortunately
> it seems it slipped through fingers.
> 

Pulled into fixes, thanks!

	Arnd
