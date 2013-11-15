From: b42378@freescale.com (Nicolin Chen)
Date: Fri, 15 Nov 2013 11:15:37 +0800
Subject: [PATCH 0/2] Add monaural audio support for fsl_ssi.c
In-Reply-To: <20131115032250.GD11014@S2101-09.ap.freescale.net>
References: <1384427230-979-1-git-send-email-b42378@freescale.com>
 <20131115030247.GC11014@S2101-09.ap.freescale.net>
 <20131115025956.GA745@MrMyself>
 <20131115032250.GD11014@S2101-09.ap.freescale.net>
Message-ID: <20131115031536.GB745@MrMyself>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 11:22:52AM +0800, Shawn Guo wrote:
> On Fri, Nov 15, 2013 at 10:59:57AM +0800, Nicolin Chen wrote:
> > Hi Shawn,
> >    
> > On Fri, Nov 15, 2013 at 11:02:49AM +0800, Shawn Guo wrote:
> > > On Thu, Nov 14, 2013 at 07:07:08PM +0800, Nicolin Chen wrote:
> > > > This series of patches need to be applied into one single tree because
> > > > the second patch depends on the first one. Without it, SSI would playback
> > > > constant noise to the right channel when playback monaural audio files on
> > > > i.MX6 Series board.
> > > 
> > > Let me try to understand if the dependency is true.
> > > 
> > > Saying I apply the DTS patch on IMX tree while Mark apply the fsl_ssi
> > > patch on his tree, will there be any regression on either IMX tree or
> > > Mark's tree?  The monaural playback on imx6qdl never worked, so it's not
> > > a regression.  If there is no regression on either tree, there is no
> > > dependency to maintain.
> > 
> > It's fair enough to understand in this way. It looks like I misunderstood
> > the dependency here.
> > 
> > Do I need to resend them separately?
> 
> No, I will just pick up the DTS patch with some testing.
> 
> Shawn

Thank you.
Nicolin Chen
