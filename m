From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 3 Aug 2013 16:43:59 -0400
Subject: [PATCH 1/2] ARM: mvebu: add support for the AXP WiFi AP board
In-Reply-To: <0DB595A2CB707F458400BE9663B6A72269594F77E1@SC-VEXCH2.marvell.com>
References: <1375199091-31215-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1375199091-31215-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130803181146.GD13555@titan.lakedaemon.net>
 <0DB595A2CB707F458400BE9663B6A72269594F77E1@SC-VEXCH2.marvell.com>
Message-ID: <20130803204359.GI13555@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Seif,

For future reference, please don't toppost.

On Sat, Aug 03, 2013 at 01:35:34PM -0700, Seif Mazareeb wrote:
> Post approval, but I've tested on my board too.
> UART, USB3.0, mini-PCIe, SPI, Sata, and Ethernet - looking good.

Shall I consider this your Tested-by ?

I can amend the commits up until I send the PR.

thx,

Jason.

> -----Original Message-----
> From: Jason Cooper [mailto:jason at lakedaemon.net] 
> Sent: Saturday, August 03, 2013 11:12 AM
> To: Thomas Petazzoni
> Cc: Andrew Lunn; Gregory Clement; Lior Amsalem; Seif Mazareeb; linux-arm-kernel at lists.infradead.org; Ezequiel Garcia
> Subject: Re: [PATCH 1/2] ARM: mvebu: add support for the AXP WiFi AP board
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
> >  arch/arm/boot/dts/armada-xp-axpwifiap.dts | 164 
> > ++++++++++++++++++++++++++++++
> >  2 files changed, 165 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/armada-xp-axpwifiap.dts
> 
> Applied to mvebu/dt
> 
> thx,
> 
> Jason.
