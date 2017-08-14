From: horms@verge.net.au (Simon Horman)
Date: Mon, 14 Aug 2017 07:37:17 +0200
Subject: [PATCH  2/2] ARM: dts: r8a7743: Add I2C DT support
In-Reply-To: <KL1PR06MB17020664F5636F87F9F97597B88B0@KL1PR06MB1702.apcprd06.prod.outlook.com>
References: <1502191449-16118-1-git-send-email-biju.das@bp.renesas.com>
 <20170809085238.GJ2705@verge.net.au>
 <KL1PR06MB17020664F5636F87F9F97597B88B0@KL1PR06MB1702.apcprd06.prod.outlook.com>
Message-ID: <20170814053717.GD5654@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 09, 2017 at 09:23:05AM +0000, Biju Das wrote:
> 
> 
> > -----Original Message-----
> > From: Simon Horman [mailto:horms at verge.net.au]
> > Sent: 09 August 2017 09:53
> > To: Biju Das <biju.das@bp.renesas.com>
> > Cc: Rob Herring <robh+dt@kernel.org>; Mark Rutland
> > <mark.rutland@arm.com>; Wolfram Sang <wsa@the-dreams.de>; Magnus
> > Damm <magnus.damm@gmail.com>; Russell King <linux@armlinux.org.uk>;
> > Chris Paterson <Chris.Paterson2@renesas.com>; devicetree at vger.kernel.org;
> > linux-renesas-soc at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> > Subject: Re: [PATCH 2/2] ARM: dts: r8a7743: Add I2C DT support
> >
> > On Tue, Aug 08, 2017 at 12:24:09PM +0100, Biju Das wrote:
> > > Add the I2C[0-5] devices to the r8a7743 device tree.
> > >
> > > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > > ---
> > > This patch has been tested against Linux-next tag 20170727 and renesas-dev
> > branch.
> > > This patch depends on
> > > https://www.mail-archive.com/linux-renesas-soc at vger.kernel.org/msg1700
> > > 8.html
> >
> > As per the patch at the link above it seems that these patches are targeted at
> > the renesas tree.  The best practice in that case is to base patches on the latest
> > devel branch. Please consider doing so in future.
> >
> > I would also slightly prefer if dependencies were referenced by name, in this
> > case:
> >
> > *  [PATCH 2/3] ARM: dts: r8a7743: Add APMU node and second CPU core
> >
> > or
> >
> > * [PATCH  0/3] Add SMP support
> >
> > Also including a link is fine by me.
> >
> >
> > It would also be useful if you described the dependency as a conflict (merge-
> > time), compile-time or run-time.
> 
> 
> Thanks Simon. I will take care this next time.
> 
> > As for the patch itself, it looks good to me.

As I believe the dependencies are apply-time and seemed easy to resolve
I have applied this patch for v4.14.
