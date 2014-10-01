From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 1 Oct 2014 17:56:11 +0200
Subject: [GIT PULL 2/3] 3rd Round of Samsung-DT-3 updates for v3.18
In-Reply-To: <54244910.3050609@samsung.com>
References: <54244910.3050609@samsung.com>
Message-ID: <201410011756.11635.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 September 2014, Kukjin Kim wrote:
> Samsung 3rd DT updates for v3.18
> 
> - Fix rebase conflcits in previous tags/samsung-dt-2
>    : Fix chip select GPIO for exynos5250-smdk5250
>    : Remove display timings node for exynos5250-snow
> 
> - Fix Exynos USB on kernels with USB Gadget support
>    : Explicitly set dr_mode for the dwc3 controller
>    for exynos5420-arndale-octa, exynos5420-peach-pit
>    and exynos5800-peach-pi boards
> 
> - add CPU nodes for exynos4210, exynos4212, exynos4412
> 

Pulled into next/late, thanks

	Arnd
