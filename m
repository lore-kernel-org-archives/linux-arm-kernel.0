From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Sep 2014 15:08:56 +0100
Subject: [PATCH 0/6] dts, kbuild: Implement support for dtb vendor subdirs
In-Reply-To: <20140919123056.GC20170@rric.localhost>
References: <1409899692-1455-1-git-send-email-rric@kernel.org>
 <CAL1qeaGCeRyeKLo70E264bZcamOfBKoN9Y8_NDCjV5j4DoOw1Q@mail.gmail.com>
 <20140919123056.GC20170@rric.localhost>
Message-ID: <20140919140856.GG2295@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 19, 2014 at 01:30:56PM +0100, Robert Richter wrote:
> On 16.09.14 20:49:18, Andrew Bresticker wrote:
> > > Robert Richter (6):
> > >   dts, arm64: Add dtbs_install make target
> > >   dts, kbuild: Factor out dtbs install rules to Makefile.dtbinst
> > >   dts, arm/arm64: Remove dtbs build rules in sub-makes
> > >   dts, kbuild: Implement support for dtb vendor subdirs
> > >   dts, arm64: Move dts files to vendor subdirs
> > >   dts, arm: Remove $(MACHINE) variable from dtbs make recipes
> > 
> > I've tested this for arm64 and by adding a vendor sub-directory
> > locally for arm.  This series is also the base for my MIPS DT vendor
> > sub-directory series
> > (http://www.linux-mips.org/archives/linux-mips/2014-09/msg00217.html).
> > So, for the entire series,
> > 
> > Tested-by: Andrew Bresticker <abrestic@chromium.org>
> 
> Andrew, thanks for testing and great this also works on mips.
> 
> Anyone willing to take the patches for 3.18? Are any further acks
> needed?

For the arm64 bits in this series:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

I think the patches can be merged via arm-soc.
