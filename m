From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 14 Jan 2014 10:15:43 +0100
Subject: [PATCH] ARM: Kirkwood: Add DT description of QNAP 419
In-Reply-To: <20140114004833.GI19878@titan.lakedaemon.net>
References: <1389048557-16364-1-git-send-email-andrew@lunn.ch>
 <20140114004833.GI19878@titan.lakedaemon.net>
Message-ID: <20140114091543.GC334@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 07:48:33PM -0500, Jason Cooper wrote:
> On Mon, Jan 06, 2014 at 11:49:17PM +0100, Andrew Lunn wrote:
> > Re-implement the Marvell Kirkwood ts41x-setup.c in DT.
> > 
> > As with the QNAP 119, there are two variants, depending on which SoC
> > has been used. They differ on Ethernet PHY addresses and number of
> > PCIe busses.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  arch/arm/boot/dts/Makefile                |    4 +-
> >  arch/arm/boot/dts/kirkwood-ts419-6281.dts |   20 ++++++++
> >  arch/arm/boot/dts/kirkwood-ts419-6282.dts |   32 ++++++++++++
> >  arch/arm/boot/dts/kirkwood-ts419.dtsi     |   75 +++++++++++++++++++++++++++++
> >  4 files changed, 130 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm/boot/dts/kirkwood-ts419-6281.dts
> >  create mode 100644 arch/arm/boot/dts/kirkwood-ts419-6282.dts
> >  create mode 100644 arch/arm/boot/dts/kirkwood-ts419.dtsi
> 
> Applied to mvebu/dt with Ian's Tested-by

Hi Jason

Thanks, but please could you hold onto it for a while. I would like to
see how the discussion about unstable /dev/input/by-path discussion
plays out. That is if anybody actually replies to my question...

      Thanks
	Andrew
