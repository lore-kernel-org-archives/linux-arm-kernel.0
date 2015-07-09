From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 9 Jul 2015 10:00:51 +0800
Subject: [PATCH] ARM: dts: vf610: Nomenclature fixup for PTA6 pin used in
 RMII mode.
In-Reply-To: <20150708135303.GD13230@lunn.ch>
References: <1434124033-13820-1-git-send-email-andrew@lunn.ch>
 <20150708091006.GC28488@tiger> <20150708135303.GD13230@lunn.ch>
Message-ID: <20150709020040.GK28488@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08, 2015 at 03:53:03PM +0200, Andrew Lunn wrote:
> On Wed, Jul 08, 2015 at 05:10:06PM +0800, Shawn Guo wrote:
> > On Fri, Jun 12, 2015 at 05:47:13PM +0200, Andrew Lunn wrote:
> > > Add a missing _ENET_ infix to PTA6 when used in RMII mode. This makes
> > > it consistent with all other pinctrl aliases for Ethernet.
> > > 
> > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > 
> > No, the existing naming is just fine, which follows how Vybrid Reference
> > Manual names them.
> 
> So are you saying you want to see a patch removing the ENET_ from
> VF610_PAD_PTC9__ENET_RMII1_MDC, VF610_PAD_PTC10__ENET_RMII1_MDIO,
> VF610_PAD_PTC11__ENET_RMII1_CRS, etc.  A quick search for VYBRIDRM Rev
> 7, 06/2014 does not get any hits for ENET_RMII

Yes.  We should keep the naming consistent with Reference Manual.

Shawn
