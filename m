From: olof@lixom.net (Olof Johansson)
Date: Sun, 27 Oct 2013 21:53:10 -0700
Subject: [GIT PULL 6/6] Samsung update for v3.13
In-Reply-To: <5264560B.504@samsung.com>
References: <5264560B.504@samsung.com>
Message-ID: <20131028045310.GL22890@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 21, 2013 at 07:15:39AM +0900, Kukjin Kim wrote:
> The following changes since commit 4a10c2ac2f368583138b774ca41fac4207911983:
> 
>   Linux 3.12-rc2 (2013-09-23 15:41:09 -0700)
> 
> are available in the git repository at:
> 

> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/exynos-dt
> 
> for you to fetch changes up to c6ad2259c629bef992be5ee82d3e74cd1e90c440:
> 
>   ARM: dts: disable PCIe for SD5v1 board (2013-10-08 06:58:01 +0900)
> 
> ----------------------------------------------------------------
> update device tree for exynos
> - add MIPI PHY node for exynos4
> - update regulator for origen and exynos5250-arndale
> - add support HDMI for exynos5250, exynos5420
> - disable PCIe for exynos5440-sd5v1

Hi,

The last patch on this branch should be done differently (the disable should be
in the dtsi instead).

Since that patch is at the very end of the branch, I'll pull in everything
but that in next/dt. You can send the patch for 5440 PCIe separately (even
as a patch instead of in a branch) and I can apply it later -- ideally
before -rc1 but at least not too long after.


-Olof
