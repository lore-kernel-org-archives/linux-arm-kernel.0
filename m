From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 3 Dec 2013 18:56:51 +0800
Subject: [PATCH 1/2] ARM: imx28: add apf28 specific initialization
 (macaddr)
In-Reply-To: <20131203095335.3c073da4@x230>
References: <1385801473-97460-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
 <20131203085030.GJ10840@S2101-09.ap.freescale.net>
 <20131203095335.3c073da4@x230>
Message-ID: <20131203105650.GB13726@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 09:53:35AM +0100, gwenhael.goavec wrote:
> On Tue, 3 Dec 2013 16:50:32 +0800
> Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> > On Sat, Nov 30, 2013 at 09:51:12AM +0100, Gwenhael Goavec-Merou wrote:
> > > Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
> > > ---
> > >  arch/arm/mach-mxs/mach-mxs.c | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
> > > index 3982e12..02b17f7 100644
> > > --- a/arch/arm/mach-mxs/mach-mxs.c
> > > +++ b/arch/arm/mach-mxs/mach-mxs.c
> > > @@ -158,6 +158,7 @@ enum mac_oui {
> > >  	OUI_DENX,
> > >  	OUI_CRYSTALFONTZ,
> > >  	OUI_I2SE,
> > 
> > What tree are you based on?  I do not have this OUI_I2SE thing in my
> > tree.
> > 
> > Shawn
> > 
> It's the for-next[1] branch of
> git://git.linaro.org/people/shawnguo/linux-2.6.git

Sorry.  I wasn't looking at the correct branch.  Applied, thanks.

Shawn
