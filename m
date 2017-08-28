From: horms@verge.net.au (Simon Horman)
Date: Mon, 28 Aug 2017 09:51:09 +0200
Subject: [PATCH v2] ARM: dts: iwg20d-q7: Add RTC support
In-Reply-To: <SG2PR06MB1711B313440D06B838E3DBD1B89A0@SG2PR06MB1711.apcprd06.prod.outlook.com>
References: <1502874990-12006-1-git-send-email-chris.paterson2@renesas.com>
 <20170824104701.GA30281@verge.net.au>
 <SG2PR06MB1711B313440D06B838E3DBD1B89A0@SG2PR06MB1711.apcprd06.prod.outlook.com>
Message-ID: <20170828075109.GB22421@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 24, 2017 at 02:53:55PM +0000, Biju Das wrote:
> 
> > -----Original Message-----
> > From: Simon Horman [mailto:horms at verge.net.au]
> > Sent: 24 August 2017 11:47
> > To: Chris Paterson <Chris.Paterson2@renesas.com>
> > Cc: Rob Herring <robh+dt@kernel.org>; Mark Rutland
> > <mark.rutland@arm.com>; Magnus Damm <magnus.damm@gmail.com>;
> > Russell King <linux@armlinux.org.uk>; Biju Das <biju.das@bp.renesas.com>;
> > devicetree at vger.kernel.org; linux-renesas-soc at vger.kernel.org; linux-arm-
> > kernel at lists.infradead.org
> > Subject: Re: [PATCH v2] ARM: dts: iwg20d-q7: Add RTC support
> >
> > On Wed, Aug 16, 2017 at 10:16:30AM +0100, Chris Paterson wrote:
> > > From: Biju Das <biju.das@bp.renesas.com>
> > >
> > > Define the iWave RainboW-G20D-Qseven board dependent part of the RTC
> > > device node.
> > >
> > > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > > [chris: corrected bq32000 compatible string]
> > > Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> > > ---
> > > v1 -> v2
> > > Added ti to bq32000 compatible string - Thanks Geert
> >
> > Thanks, applied for v4.15.
> 
> Looks like i2c2_pins nodes are misplaced. Please drop this patch,
> So that I can send a new patch.

Thanks, I have dropped the patch.
