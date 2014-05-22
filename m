From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 May 2014 22:38:41 -0700
Subject: [GIT PULL 5/5] Samsung Exynos MCPM support for 3.16
In-Reply-To: <014801cf73c8$7d1f9930$775ecb90$@samsung.com>
References: <014801cf73c8$7d1f9930$775ecb90$@samsung.com>
Message-ID: <20140522053841.GI32618@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 10:11:54AM +0900, Kukjin Kim wrote:
> The following changes since commit d7067f1c5fa0232001502569c6878d22308da268:
> 
>   devicetree: bindings: document SYSRAM binding (2014-05-15 03:30:29 +0900)
> 
> are available in the git repository at:
> 
>   http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/exynos-mcpm
> 
> for you to fetch changes up to ccf5511797cd4b48d20a85fa1778f5608eac9fd7:
> 
>   ARM: EXYNOS: Add MCPM call-back functions (2014-05-16 04:26:30 +0900)
> 
> ----------------------------------------------------------------
> Exynos MCPM support for v3.16
> 
> - adding MCPM backend support for SMP secondary boot and core switching
> on Samsung's Exynos5420.
> 
> Tested on exynos5420-smdk5420 and exynos5420 based chromebook (peach-pit)
> using the "/dev/b.L_switcher" user interface. Secondary core boot-up has
> also been tested on both the boards.

This goes with new SoC enablement as well; we'll merge it after multi-platform.


Thanks!


-Olof
