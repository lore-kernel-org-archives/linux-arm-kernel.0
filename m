From: horms@verge.net.au (Simon Horman)
Date: Thu, 17 May 2018 11:03:00 +0200
Subject: [PATCH v2 3/3] arm64: dts: renesas: draak: Describe HDMI input
In-Reply-To: <20180517071456.GT5956@w540>
References: <1526478129-16465-1-git-send-email-jacopo+renesas@jmondi.org>
 <1526478129-16465-4-git-send-email-jacopo+renesas@jmondi.org>
 <20180516222318.GI17948@bigcity.dyn.berto.se>
 <20180517071456.GT5956@w540>
Message-ID: <20180517090259.ps6ikcgdxxpfr2ac@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 09:14:56AM +0200, jacopo mondi wrote:
> Hi Niklas,
> 
> On Thu, May 17, 2018 at 12:23:18AM +0200, Niklas S?derlund wrote:
> > Hi Jacopo,
> >
> > Thanks for your patch.
> >
> > On 2018-05-16 15:42:09 +0200, Jacopo Mondi wrote:
> > > Describe HDMI input connector and ADV7612 HDMI decoder installed on
> > > R-Car Gen3 Draak board.
> > >
> > > The video signal routing to the HDMI decoder to the video input interface
> > > VIN4 is multiplexed with CVBS input path, and enabled/disabled through
> > > on-board switches SW-49, SW-50, SW-51 and SW-52.
> > >
> > > As the default board switches configuration connects CVBS input to VIN4,
> > > leave the HDMI decoder unconnected in DTS.
> > >
> > > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> >
> > I'm not sure we have a policy about describing hardware which can't be
> > used without flipping switches. I have no opinion on if we should do
> > that or not I leave that to others, but for the change itself.
> >
> > Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
> >
> 
> Thanks
> 
> > I think it's good we describe it as it's part of the Draak board itself
> > and not an expansion board which we have seen a lot of :-) Maybe even
> > add a commented out line in the adv7612 port at 2 which hints which VIN
> > this is connected to if the switches are flipped?
> 
> The only VIN instance that's on Draak, VIN4.
> 
> I can add a comment that describes the switch settings that enables
> the HDMI video capture path.

That sounds like a good plan to me.
