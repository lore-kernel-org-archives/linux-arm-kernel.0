From: olof@lixom.net (Olof Johansson)
Date: Mon, 26 Nov 2012 00:32:32 -0800
Subject: [GIT PULL 3/3] Samsung exynos5440 for v3.8
In-Reply-To: <10d401cdc91b$09fe1980$1dfa4c80$%kim@samsung.com>
References: <10d401cdc91b$09fe1980$1dfa4c80$%kim@samsung.com>
Message-ID: <20121126083232.GH9580@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 10:37:03AM +0900, Kukjin Kim wrote:
> Arnd, Olof,
> 
> This is adding support for exynos5440, including Quad ARM Cortex-A15 cores
> and its reference board SSDK5440.
> 
> Note, at this moment, just enabled minimal system part for initial kernel
> boot and pinctrl driver.
> 
> Please pull from:
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> next/soc-exynos5440

Merged. This caused some new conflicts with previous samsung contents, since
you add DT contents in several branches, etc. Please try to work on getting
your amount of conflicts down a bit.

If you want a good example to look at, see how Tony Lindgren handles OMAP.
He's juggling a large number of topics with nearly no conflicts left
for us to resolve at our level, by making sure new work is based on
appropriate base branches.


-Olof
