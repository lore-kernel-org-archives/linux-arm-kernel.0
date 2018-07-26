From: olof@lixom.net (Olof Johansson)
Date: Thu, 26 Jul 2018 00:12:34 -0700
Subject: [GIT PULL] Allwinner drivers changes for 4.19
In-Reply-To: <20180724131616.brtatxqutdjd4oxt@flea>
References: <20180724131616.brtatxqutdjd4oxt@flea>
Message-ID: <20180726071234.tzhxtarbmlsysz65@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 03:16:16PM +0200, Maxime Ripard wrote:
> Hi Arnd, Olof,
> 
> Please pull the following changes for the next merge window.
> 
> Thanks!
> Maxime
> 
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-drivers-for-4.19
> 
> for you to fetch changes up to 7377330a1ed2e9bb5a97758bdadcdb37e2201b2a:
> 
>   soc: sunxi: Add the A13, A23 and H3 system control compatibles (2018-07-19 16:39:12 +0200)
> 
> ----------------------------------------------------------------
> Allwinner drivers changes for 4.19
> 
> There's been work for this release cycles in both the SRAM controller
> driver in order to support more SoCs, as part of our VPU work, but also to
> enable the EMAC on the A64 (that needs to poke at registers within the same
> register space).
> 
> Some work has been needed too to represent the bus to the display engine
> controllers that all need an SRAM to be mapped to the CPU to be able to
> access those controllers' registers.

Merged, thanks!


-Olof
