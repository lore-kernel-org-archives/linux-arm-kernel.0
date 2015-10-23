From: olof@lixom.net (Olof Johansson)
Date: Fri, 23 Oct 2015 10:20:12 -0700
Subject: [GIT PULL] Allwinner core changes for 4.4
In-Reply-To: <20151017165114.GA15258@lukather>
References: <20151017165114.GA15258@lukather>
Message-ID: <20151023172012.GG2224@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 17, 2015 at 06:51:14PM +0200, Maxime Ripard wrote:
> Hi Arnd, Kevin, Olof,
> 
> Please pull the following tag that adds the needed code to support the
> R8 properly.
> 
> Thanks!
> Maxime
> 
> The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:
> 
>   Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-core-for-4.4
> 
> for you to fetch changes up to bef6229f36c1c2ddae186f4e328c2359c1dad18d:
> 
>   ARM: sunxi: Add R8 support (2015-10-17 18:47:28 +0200)
> 
> ----------------------------------------------------------------
> Allwinner core changes for 4.4
> 
> Add support for the Allwinner R8 SoC used in the CHIP.
> 
> ----------------------------------------------------------------
> Maxime Ripard (1):
>       ARM: sunxi: Add R8 support
> 
>  Documentation/arm/sunxi/README                  | 2 +-
>  Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
>  arch/arm/mach-sunxi/sunxi.c                     | 3 ++-
>  drivers/clk/sunxi/clk-sunxi.c                   | 1 +
>  4 files changed, 5 insertions(+), 2 deletions(-)

5 lines to support a new SoC? Nice work.

Merged.


-Olof
