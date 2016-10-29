From: olof@lixom.net (Olof Johansson)
Date: Sat, 29 Oct 2016 11:08:48 -0700
Subject: [GIT PULL] i.MX fixes for 4.9
In-Reply-To: <20161024140622.GM30578@tiger>
References: <20161024140622.GM30578@tiger>
Message-ID: <20161029180848.GB4195@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2016 at 10:06:22PM +0800, Shawn Guo wrote:
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.9
> 
> for you to fetch changes up to 4edd601c5a9c5094daa714e65063e623826f3bcc:
> 
>   ARM: imx: mach-imx6q: Fix the PHY ID mask for AR8031 (2016-10-24 21:26:01 +0800)
> 
> ----------------------------------------------------------------
> The i.MX fixes for 4.9:
>  - A couple of patches from Fabio to fix the GPC power domain regression
>    which is caused by PM Domain core change 0159ec670763dd
>    ("PM / Domains: Verify the PM domain is present when adding a
>    provider"), and a related kernel crash seen with multi_v7_defconfig
>    build.
>  - Correct the PHY ID mask for AR8031 to match phy driver code.
>  - Apply new added timer erratum A008585 for LS1043A and LS2080A SoC.
>  - Correct vf610 global timer IRQ flag to avoid warning from gic driver
>    after commit 992345a58e0c ("irqchip/gic: WARN if setting the
>    interrupt type for a PPI fails").

Merged, thanks.


-Olof
