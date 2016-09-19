From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Sep 2016 17:02:40 +0200
Subject: [GIT PULL 1/3] ARM: soc: exynos: Drivers for v4.9
In-Reply-To: <1474216788-17282-2-git-send-email-krzk@kernel.org>
References: <1474216788-17282-1-git-send-email-krzk@kernel.org>
 <1474216788-17282-2-git-send-email-krzk@kernel.org>
Message-ID: <2663426.T8oUku18qe@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, September 18, 2016 6:39:46 PM CEST Krzysztof Kozlowski wrote:
> Samsung drivers/soc update for v4.9:
> 1. Allow compile testing of exynos-mct clocksource driver on ARM64.
> 2. Document Exynos5433 PMU compatible (already used by clkout driver and more
>    will be coming soon).

Pulled into next/drivers, thanks

Just for my understanding: why do we need the exynos-mct driver on ARM64
but not the delay-timer portion of it?

Is there an advantage in using MCT over the architected timer on these
chips? If so, should we also have a way to use it as the delay timer?

	Arnd
