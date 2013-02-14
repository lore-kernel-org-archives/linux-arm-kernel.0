From: horms@verge.net.au (Simon Horman)
Date: Thu, 14 Feb 2013 09:56:58 +0900
Subject: [PATCH 00/16 v1.1] SCIF, I2C and FSI pinctrl functions for sh73a0
In-Reply-To: <1966083.UGpBDi27xI@avalon>
References: <1360723497-23266-1-git-send-email-horms+renesas@verge.net.au>
 <1911001.oocnvCx2VX@avalon> <20130213162106.GB10520@verge.net.au>
 <1966083.UGpBDi27xI@avalon>
Message-ID: <20130214005658.GF15879@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 05:32:40PM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Thursday 14 February 2013 01:21:06 Simon Horman wrote:
> > On Wed, Feb 13, 2013 at 05:06:30PM +0100, Laurent Pinchart wrote:
> > > On Wednesday 13 February 2013 11:44:36 Simon Horman wrote:
> > > > Hi,
> > > > 
> > > > this series is a follow-up to "[PATCH 00/16] SCIF, I2C and FSI pinctrl
> > > > functions for sh73a0" by Laurent Pinchart. I am primarily posting it for
> > > > his review.
> > > > 
> > > > This series differs from the series posted by Laurent in the following
> > > > ways:
> > > > 
> > > > * Due to some slightly over-zelous git use on my part the series
> > > >   is actually based on a checkout of
> > > >   git://linuxtv.org/pinchartl/fbdev.git pinmux-pfc-funcs
> > > >   
> > > >   As such it includes several patches not included in the series posted
> > > >   in via eimal as the series "[PATCH 00/16] SCIF, I2C and FSI pinctrl
> > > >   functions for sh73a0". In particular it includes r8a7740 and r8a7779
> > > >   patches.
> > > > 
> > > > * I have added the following two patches to update the KZM9G rerence
> > > > code.
> > > > 
> > > >   ARM: shmobile: kzm9g: reference: Register pinctrl mappings for I2C
> > > >   ARM: shmobile: kzm9g: reference: Register pinctrl mappings for SCIF
> > > > 
> > > > As implied by the second point above, this series is based on
> > > > a branch that includes the kzm9g reference code. That branch is
> > > > 
> > > > 	git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git
> > > > 
> > > > topic/pinmux-base
> > > 
> > > When do you plan to push that reference code to mainline ?
> > 
> > As soon as I start pushing stuff for v3.10.
> > So I am thinking in terms of before pinmux.
> > But the order can be changed if need be.
> 
> I'm fine with any order, really. Just keep the patches warm in a corner, and 
> push the kzm9g-reference code whenever you want to. If you're faster than me 
> please drop me an e-mail to tell me where I can get the latest kzm9g-reference 
> pinctrl patches and I'll apply them to my tree.

Good plan.
