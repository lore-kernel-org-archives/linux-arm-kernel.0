From: olof@lixom.net (Olof Johansson)
Date: Fri, 30 Nov 2012 09:33:52 -0800
Subject: [GIT PULL 6/7] Samsung devel-3 for v3.8
In-Reply-To: <50B557CE.7050909@samsung.com>
References: <50B557CE.7050909@samsung.com>
Message-ID: <20121130173352.GE697@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 28, 2012 at 09:16:14AM +0900, Kukjin Kim wrote:
> Arnd, Olof
> 
> This is including Samsung small updates(developments) for v3.8.
> 
> add node PL330 MDMA1 and UART3 for DEBUG_LL and secondary cpu
> bring-up for exynos4412.
> 
> Please pull from:
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> next/devel-samsung-3

Please try to avoid these "devel" branches -- call them a proper topic
instead. These seem to be:

> Bartlomiej Zolnierkiewicz (1):
>       ARM: dts: add node for PL330 MDMA1 controller for exynos4

That's a dt patch.

> 
> Olof Johansson (1):
>       ARM: EXYNOS: add UART3 to DEBUG_LL ports

This is a soc support patch, or maybe driver.

> Tomasz Figa (1):
>       ARM: EXYNOS: Add support for secondary CPU bring-up on Exynos4412

That's another soc support patch.


I will pull this into next/soc since 2 out of the three patches belong there.


-Olof
