From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 14:31:09 -0800
Subject: [GIT PULL] soc: samsung: Drivers for v4.11
In-Reply-To: <20170120181343.12570-1-krzk@kernel.org>
References: <20170120181343.12570-1-krzk@kernel.org>
Message-ID: <20170129223109.GB3133@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 08:13:43PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> Few changes in Exynos PMU driver including one that is needed by pinctrl
> driver for runtime PM. We want to move forward with the RPM for our drivers
> while keeping still DT ABI.
> 
> 
> This tag is also for Linus Walleij to pull - base for pinctrl changes.
> 
> Best regards,
> Krzysztof
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> 
> 
> The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:
> 
>   Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git samsung-drivers-soc-pmu-4.11
> 
> for you to fetch changes up to 1da6de33e43901ec5220cbf292d71172635ada67:
> 
>   soc: samsung: pmu: Remove messages for failed memory allocation (2017-01-20 18:37:27 +0200)
> 
> ----------------------------------------------------------------
> Improvements for Exynos PMU driver for v4.11:
> 
> Beside basic function of setting proper configuration for low power modes, the
> Exynos PMU (Power Management Unit) driver is also a provider of syscon regmap
> for its registers.  This regmap is essential to many other drivers wanting to
> or needing to implement low power mode.
> 
> Exynos pinctrl driver, before getting support for Runtime Power Management,
> needs access to this syscon regmap.  Let's do it in a DT ABI friendly way.

Merged here as well.

THanks,

-Olof
