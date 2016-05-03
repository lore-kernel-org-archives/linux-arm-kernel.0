From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 May 2016 11:32:37 +0100
Subject: [PATCH v2 0/3] ARM: nommu: R-class fixes
In-Reply-To: <57287BD9.6090907@arm.com>
References: <1461862316-9877-1-git-send-email-vladimir.murzin@arm.com>
 <57287BD9.6090907@arm.com>
Message-ID: <20160503103237.GN19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 03, 2016 at 11:22:17AM +0100, Vladimir Murzin wrote:
> On 28/04/16 17:51, Vladimir Murzin wrote:
> > Small set of fixes discovered with R-class cores.
> > 
> > Jean-Philippe Brucker (2):
> >   ARM: nommu: fix PMSAv7 setup
> >   ARM: nommu: change memory reserve for the vectors
> > 
> > Vladimir Murzin (1):
> >   ARM: domain: move {set,get}_domain under config guard
> > 
> >  arch/arm/include/asm/domain.h |   11 +++++++++++
> >  arch/arm/kernel/head-nommu.S  |    2 +-
> >  arch/arm/mm/nommu.c           |   15 ++++++++-------
> >  3 files changed, 20 insertions(+), 8 deletions(-)
> > 
> 
> Russell, any objection to get it into patch tracker?

I've not had any chance to look at them yet - last weekend, I was away
from Thursday through until late Tuesday, then I spent most of Wednesday
and Thursday catching up.  Friday I was able to look at some stuff, and
then I've spent the bank holiday weekend digging out laurels in the front
garden.  I've only just today got back to looking at some kernel stuff.

So really, I've only had two days in the last week and a half to look at
anything.

Please wait a little while longer.  Thanks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
