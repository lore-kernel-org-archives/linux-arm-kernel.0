From: jason@lakedaemon.net (Jason)
Date: Fri, 2 Mar 2012 12:56:18 -0500
Subject: [PULL REQUEST] ARM: kirkwood: fdt: convert kirkwood init funcs
 to fdt
In-Reply-To: <20120302175233.GM11986@titan.lakedaemon.net>
References: <cover.1330625877.git.jason@lakedaemon.net>
 <cover.1330709314.git.jason@lakedaemon.net>
 <20120302175233.GM11986@titan.lakedaemon.net>
Message-ID: <20120302175618.GN11986@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oops, forgot to remove the Re:...

On Fri, Mar 02, 2012 at 12:52:33PM -0500, Jason wrote:
> The following changes since commit 759a45185ac0e4dfaf8bbfcb390ec73aca4b7a34:
> 
>   ARM: kirkwood: convert uart0 to devicetree. (2012-02-27 16:21:44 +0000)
> 
> are available in the git repository at:
>   git://git.infradead.org/users/jcooper/linux-kirkwood.git kirkwood_dt_test
> 
> Jason Cooper (5):
>       ARM: kirkwood: covert orion-spi to fdt.
>       ARM: kirkwood: move var setting to correct location.
>       ARM: kirkwood: fdt: absorb kirkwood_init()
>       ARM: kirkwood: convert rtc-mv to fdt.
>       ARM: kirkwood: convert orion-wdt to fdt.
> 
>  arch/arm/boot/dts/kirkwood-dreamplug.dts |   34 +++++++++++++++
>  arch/arm/boot/dts/kirkwood.dtsi          |   12 +++++
>  arch/arm/mach-kirkwood/board-dt.c        |   67 +++++++++++------------------
>  arch/arm/mach-kirkwood/common.c          |   21 +++++++--
>  arch/arm/mach-kirkwood/common.h          |    6 +++
>  drivers/rtc/rtc-mv.c                     |    7 +++
>  drivers/spi/spi-orion.c                  |   37 +++++++++++++++--
>  drivers/watchdog/orion_wdt.c             |   48 ++++++++++++++++-----
>  8 files changed, 170 insertions(+), 62 deletions(-)
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
