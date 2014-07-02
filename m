From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 2 Jul 2014 12:38:44 +0800
Subject: [PATCH v2 0/5] some additions for the edmqmx6 board
In-Reply-To: <cover.1404212584.git.silvio.fricke@gmail.com>
References: <cover.1404132504.git.silvio.fricke@gmail.com>
 <cover.1404212584.git.silvio.fricke@gmail.com>
Message-ID: <20140702043842.GB16176@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 01:08:57PM +0200, Silvio Fricke wrote:
> Hi,
> 
> please add this patches to your imx-tree.
> 
> v2:
> * add changes suggested by Shawn Guo
>   * iomux config changed for can and pcie-reset gpio
>   * flexcan not as module
> 
> Thank you and bye,
> Silvio
> 
> 
> Silvio Fricke (5):
>   ARM: imx_v6_v7_defconfig: Enable STMPE gpio support
>   ARM: dts: imx6: edmqmx6: Add PCIe support
>   ARM: dts: imx6: edmqmx6: Add two other i2c buses
>   ARM: dts: imx6: edmqmx6: Add can bus
>   ARM: imx_v6_v7_defconfig: Enable flexcan driver for can support

Applied all, thanks.
