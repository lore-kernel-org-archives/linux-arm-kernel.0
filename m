From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 8 Nov 2011 03:33:35 -0700 (MST)
Subject: [GIT PULL] ARM: OMAP: DSS hwmod/reset fixes for 3.2
In-Reply-To: <1320746911.1907.47.camel@deskari>
References: <alpine.DEB.2.00.1110061806150.4611@utopia.booyaka.com>
 <20111105003550.GM31337@atomide.com>
 <alpine.DEB.2.00.1111080049470.12394@utopia.booyaka.com>
 <1320746911.1907.47.camel@deskari>
Message-ID: <alpine.DEB.2.00.1111080329300.8313@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Nov 2011, Tomi Valkeinen wrote:

> On Tue, 2011-11-08 at 00:50 -0700, Paul Walmsley wrote:
> > On Fri, 4 Nov 2011, Tony Lindgren wrote:
> > 
> > > * Paul Walmsley <paul@pwsan.com> [111006 16:33]:
> > > > The following changes since commit be73246058737beec52ae232bcab7776332a9e06:
> > > > 
> > > >   ARM: OMAP2+: Remove custom init_irq for remaining boards (2011-09-26 17:50:37 -0700)
> > > > 
> > > > are available in the git repository at:
> > > >   git://git.pwsan.com/linux-2.6 hwmod_dss_fixes_3.2
> > > 
> > > Looks like you should take a look at the merge conflicts with
> > > this one, maybe rebase it on 994c0e992522c123298b4a91b72f5e67ba2d1123.
> > 
> > Do you want this series for 3.2-rc or 3.3 at this point?
> 
> Seems that at least HDMI output is broken due to this series missing.

OK thanks, 3.2-rc it is.

The merge conflicts have been fixed, they were trivial.  Tomi, care to 
do a quick test boot with the updated branch

git://git.pwsan.com/linux-2.6 hwmod_dss_fixes_3.2rc

?

My testbed is down at the moment and won't have the chance to deal with it 
for a few more days.


- Paul
