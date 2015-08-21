From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Aug 2015 18:37:26 -0700
Subject: [GIT PULL v2 2/5] Samsung 2nd DT updates for v4.3
In-Reply-To: <55CCE6F6.1090001@kernel.org>
References: <55CCE517.2070003@kernel.org>
 <55CCE6F6.1090001@kernel.org>
Message-ID: <20150821013726.GE4865@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 03:50:30AM +0900, Kukjin Kim wrote:
> The following changes since commit 5e080b078fa1f929d9aa5586985d5e7c0739d207:
> 
>   ARM: dts: Extend exynos5420-pinctrl nodes using labels instead of
> paths (2015-07-21 13:01:23 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/samsung-late-dt
> 
> for you to fetch changes up to ba032795463bfc461937dbde7a345103a47f969b:
> 
>   ARM: dts: add iommu property to JPEG device for exynos4 (2015-08-14
> 02:30:58 +0900)
> 
> ----------------------------------------------------------------
> Samsung 2nd DT updates for v4.3
> 
> - for exynos3250, 4212, 4412 and 5250
>   : add CPU OPP and regulator supply property
> 
> - for exynos3250
>   : add CPU cooling binding for exynos3250 boards
> 
> - for exynos4 SoCs
>   : add iommu property to JPEG device
> 
> - for exynos4412-odroidu3
>   : enable SPI1
> 
> - for exynos5250-snow
>   : add SPI CS
> 
> - for exynos5422
>   : add exynos5422-cpus.dtsi to correct cpu order
> 
> * Note this branch is depending on tags/samsung-clk-driver

It's not depending on it, it contains it -- which is what's required here or
bisectability would be broken.

Merged into next/late.


-Olof
