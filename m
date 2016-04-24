From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 24 Apr 2016 23:15:52 +0200
Subject: [GIT PULL 1/5] ARM: dts: exynos: Artik5 topic branch for v4.7
In-Reply-To: <1460541682-32417-2-git-send-email-k.kozlowski@samsung.com>
References: <1460541682-32417-1-git-send-email-k.kozlowski@samsung.com>
 <1460541682-32417-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <7068458.f0qaFCRyGK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 April 2016 12:01:18 Krzysztof Kozlowski wrote:
> Topic branch for Device Tree changes for Exynos 3250 for v4.7:
> 
> Merge necessary new clocks from Sylwester (used by new board) and add support
> for Exynos3250-based Artik5 board.
> 

Merged into next/dt, thanks!

I see that you have modified the include/dt-bindings/clock/exynos3250.h
file. Two questions about that:

- How is this going to get synchronized with the respective driver changes
  in a way that avoids breaking the build of the clk tree? Do you just
  wait another merge window for that?

- Are there any other clocks that you should define now so you don't run
  into dependency problems later?

	Arnd
