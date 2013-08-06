From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 6 Aug 2013 13:32:41 -0300
Subject: [PATCH 1/2] ARM: mvebu: add support for the AXP WiFi AP board
In-Reply-To: <20130806155343.GU19280@titan.lakedaemon.net>
References: <1375199091-31215-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1375199091-31215-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130806155343.GU19280@titan.lakedaemon.net>
Message-ID: <20130806163240.GB2705@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 06, 2013 at 11:53:43AM -0400, Jason Cooper wrote:
> Ezequiel,
> 
> On Tue, Jul 30, 2013 at 05:44:50PM +0200, Thomas Petazzoni wrote:
> > The AXP WiFi AP board is a Marvell platform based on the Armada XP
> > MV78230 SoC. It has two mini-PCIe connectors, one USB 3.0 port powered
> > by a USB 3.0 controller on PCIe, two Ethernet ports, 1 GB of RAM, 1 GB
> > of NAND, 16 MB of SPI flash, one SATA port and one button, two UARTs
> > 
> > Successfully tested: USB 3.0 port, the mini-PCIe connectors, SPI
> > flash, Ethernet ports, SATA port, button, UART.
> > 
> > Untested: NAND flash, due to lack of mainline support for the Armada
> > 370/XP NAND controller for now.
> > 
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/Makefile                |   1 +
> >  arch/arm/boot/dts/armada-xp-axpwifiap.dts | 164 ++++++++++++++++++++++++++++++
> >  2 files changed, 165 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/armada-xp-axpwifiap.dts
> 
> When I merge this code with your MBus series I get the following
> warning:
> 
>   DTC     arch/arm/boot/dts/armada-xp-axpwifiap.dtb
> Warning (ranges_format): "ranges" property in /soc has invalid length (32 bytes)
>  (parent #address-cells == 2, child #address-cells == 2, #size-cells == 1)
> 
> Could you please take a look and provide a separate patch to fix it up?
> 

Sure. Let me take a look.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
