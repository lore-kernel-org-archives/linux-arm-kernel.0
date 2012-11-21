From: horms@verge.net.au (Simon Horman)
Date: Wed, 21 Nov 2012 10:29:53 +0900
Subject: [RFC 09/15] ARM: shmobile: Include DTSI of r8a7740 to
 armadillo800eva
In-Reply-To: <19065301.iqf7oYnrtW@avalon>
References: <1353302007-31045-1-git-send-email-horms@verge.net.au>
 <2217502.K9pLuGzWaC@avalon> <20121121001457.GG20120@verge.net.au>
 <19065301.iqf7oYnrtW@avalon>
Message-ID: <20121121012953.GB2897@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 02:03:02AM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Wednesday 21 November 2012 09:14:57 Simon Horman wrote:
> > On Tue, Nov 20, 2012 at 01:45:20PM +0100, Laurent Pinchart wrote:
> > > Hi Simon,
> > > 
> > > Thank you for the patch.
> > > 
> > > On Monday 19 November 2012 14:13:21 Simon Horman wrote:
> > > > From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> > > > 
> > > > Cc: Magnus Damm <damm@opensource.se>
> > > > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> > > > Signed-off-by: Simon Horman <horms@verge.net.au>
> > > 
> > > I came up today with pretty much the same patch :-)
> > > 
> > > > ---
> > > > 
> > > >  arch/arm/boot/dts/r8a7740-armadillo800eva.dts |    2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
> > > > b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts index a7505a9..a8e7bd9
> > > > 100644
> > > > --- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
> > > > +++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
> > > > @@ -9,7 +9,7 @@
> > > > 
> > > >   */
> > > >  
> > > >  /dts-v1/;
> > > > 
> > > > -/include/ "skeleton.dtsi"
> > > > +/include/ "r8a7740.dtsi"
> > > > 
> > > >  / {
> > > >  
> > > >  	model = "armadillo 800 eva";
> > > 
> > > Shouldn't the compatible property be modified to the following values ?
> > > 
> > > 	compatible = "renesas,armadillo800eva", "renesas,r8a7740";
> > 
> > To be honest, I'm not sure.
> > But as this is a dts file for a board "renesas,r8a7740" seems strange to me.
> 
> If I understand DT correctly, the goal is to get rid of the board file at
> some point and only keep the generic r8a7740 board code. Shouldn't we
> then match on "renesas,r8a7740" ?

Yes, I think that makes sense.
