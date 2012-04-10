From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Apr 2012 09:47:02 +0100
Subject: [PATCH/RFC v2] ARM: amba: Remove AMBA level regulator support
In-Reply-To: <20120410083543.GC3149@opensource.wolfsonmicro.com>
References: <1333306720-28344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20120406074942.GO7264@S2101-09.ap.freescale.net>
 <20120410083130.GK24211@n2100.arm.linux.org.uk>
 <20120410083543.GC3149@opensource.wolfsonmicro.com>
Message-ID: <20120410084702.GM24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2012 at 09:35:43AM +0100, Mark Brown wrote:
> On Tue, Apr 10, 2012 at 09:31:30AM +0100, Russell King - ARM Linux wrote:
> > On Fri, Apr 06, 2012 at 03:49:45PM +0800, Shawn Guo wrote:
> > > I believe this patch fixes the amba probe failure that impacts any
> > > AMBA platform build with CONFIG_REGULATOR enabled.  Could you consider
> > > to send the fix for -rc soon?
> 
> > No idea.  I don't have Mark's patch in the patch system.
> 
> It's there as far as I can tell - it's 7366/1, which is visible in the
> web interface at:
> 
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7366/1
> 
> Is there something else I need to do?

Ok, I thought 7366/1 and 7367/1 were part of the same looking at just the
index.

In any case, what would really help is if people would discard patches
they no longer want applying.
