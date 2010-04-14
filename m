From: andy@warmcat.com (Andy Green)
Date: Wed, 14 Apr 2010 09:11:48 +0100
Subject: [PATCH 1/3] ARM: MXC: mxcmmc: misc cleanups
In-Reply-To: <20100414072116.GG7882@pengutronix.de> (from
	s.hauer@pengutronix.de on Wed Apr 14 08:21:16 2010)
Message-ID: <1271232708.22125.1@otae>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14/10 08:21:16, Sascha Hauer wrote:
> On Tue, Apr 13, 2010 at 12:34:11PM +0200, Daniel Mack wrote:
> > On Thu, Apr 08, 2010 at 11:34:38AM +0200, Sascha Hauer wrote:
> > > On Tue, Apr 06, 2010 at 12:44:55PM +0200, Daniel Mack wrote:
> > > > Is this series ok to go in?
> > > > Sascha, will this go thru your tree?
> > > 
> > > Can do. One of your patches touches the generic SDIO layer. Can I
> have
> > > an acked-by from someone involved in it?
> > 
> > I think you can get a Tested-by: from Volker Ernst and Andy Green
> > and a Reviewed-by: from Micha? Miros?aw who was guiding me thru the
> > locking bits. Can anyone give some thumbs-up, please?
> 
> Ok, I think it's been enough time for someone to complain. Applied to
> mxc-master.

Sorry I was travelling yesterday.  The patch is definitely worth 
having.

We've been running a variation of this patch for several days, however 
not 100% the same since Volker has ported the iMX31 SDMA engine from 
the freescale tree for a few weeks now on our tree, and now has the 
SDIO working through SDMA (and a second channel with SD Card also 
on SDMA) FWIW.

We're not planning to do the work to get that into mainline but I think 
Daniel expressed an interest.

-Andy
