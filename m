From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 1 Jul 2014 17:09:23 +0800
Subject: [PATCH 0/5] some additions for the edmqmx6 board
In-Reply-To: <cover.1404132504.git.silvio.fricke@gmail.com>
References: <cover.1404132504.git.silvio.fricke@gmail.com>
Message-ID: <20140701090922.GH14471@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 03:28:04PM +0200, Silvio Fricke wrote:
> Hi,
> 
> please add this patches to your imx-tree.
> 
> Is it possible to add the first patch to your current imx-fixes branch?

No.  Since it's already -rc3, arm-soc folks will require the patches
going into -rc fix critical bugs or regressions.

Shawn

> The
> boards give some warnings of unresolved depencies like "gpio-leds: Driver
> leds-gpio requests probe deferral" . With these patches it is gone.
> 
> 
> Thank you and bye,
> Silvio
> 
> 
> 
> Silvio Fricke (5):
>   ARM: imx_v6_v7_defconfig: Enable STMPE gpio support
>   ARM: dts: imx6: edmqmx6: Add PCIe support
>   ARM: dts: imx6: edmqmx6: Add two other i2c busses
>   ARM: dts: imx6: edmqmx6: Add can bus
>   ARM: imx_v6_v7_defconfig: Enable flexcan driver for can support
> 
>  arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts | 54 +++++++++++++++++++++++++++++++++
>  arch/arm/configs/imx_v6_v7_defconfig    |  3 ++
>  2 files changed, 57 insertions(+)
> 
> -- 
> 2.0.0
> 
