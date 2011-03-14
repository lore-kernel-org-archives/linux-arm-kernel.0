From: premi@ti.com (Premi, Sanjeev)
Date: Mon, 14 Mar 2011 19:47:03 +0530
Subject: [PATCH] omap3: alsa-soc: Remove restrictive check for cpu type
In-Reply-To: <20110314160040.c15c0c8d.jhnikula@gmail.com>
References: <1300109513-29002-1-git-send-email-premi@ti.com>
	<20110314155542.b60bd852.jhnikula@gmail.com>
	<20110314160040.c15c0c8d.jhnikula@gmail.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C2469DA@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Jarkko Nikula [mailto:jhnikula at gmail.com] 
> Sent: Monday, March 14, 2011 7:31 PM
> To: Premi, Sanjeev
> Cc: linux-omap at vger.kernel.org; alsa-devel at alsa-project.org; 
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] omap3: alsa-soc: Remove restrictive 
> check for cpu type
> 
> On Mon, 14 Mar 2011 15:55:42 +0200
> Jarkko Nikula <jhnikula@gmail.com> wrote:
> 
> > On Mon, 14 Mar 2011 19:01:53 +0530
> > Sanjeev Premi <premi@ti.com> wrote:
> > 
> > > Current check for cpu type is too restrictive leading to
> > > failures for other silicons in same family.
> > > 
> > > The problem was found while testing audio playback on
> > > AM37x and AM35x processors. But should exist on OMAP36xx
> > > as well.
> > > 
> > > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > > ---
> > >  sound/soc/omap/omap-mcbsp.c |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > 
> > There are two other cpu_is_omap343x tests as well. Care to 
> check them
> > too?
> > 
> Sorry, only one additional test. I forgot the commit 2686e07 "ASoC:
> McBSP: get hw params from McBSP driver" that is coming via linux-omap
> and which removes one test.

Checking now...

~sanjeev

> 
> -- 
> Jarkko
> 
