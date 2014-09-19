From: rric@kernel.org (Robert Richter)
Date: Fri, 19 Sep 2014 14:30:56 +0200
Subject: [PATCH 0/6] dts, kbuild: Implement support for dtb vendor subdirs
In-Reply-To: <CAL1qeaGCeRyeKLo70E264bZcamOfBKoN9Y8_NDCjV5j4DoOw1Q@mail.gmail.com>
References: <1409899692-1455-1-git-send-email-rric@kernel.org>
 <CAL1qeaGCeRyeKLo70E264bZcamOfBKoN9Y8_NDCjV5j4DoOw1Q@mail.gmail.com>
Message-ID: <20140919123056.GC20170@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.09.14 20:49:18, Andrew Bresticker wrote:

> > Robert Richter (6):
> >   dts, arm64: Add dtbs_install make target
> >   dts, kbuild: Factor out dtbs install rules to Makefile.dtbinst
> >   dts, arm/arm64: Remove dtbs build rules in sub-makes
> >   dts, kbuild: Implement support for dtb vendor subdirs
> >   dts, arm64: Move dts files to vendor subdirs
> >   dts, arm: Remove $(MACHINE) variable from dtbs make recipes
> 
> I've tested this for arm64 and by adding a vendor sub-directory
> locally for arm.  This series is also the base for my MIPS DT vendor
> sub-directory series
> (http://www.linux-mips.org/archives/linux-mips/2014-09/msg00217.html).
> So, for the entire series,
> 
> Tested-by: Andrew Bresticker <abrestic@chromium.org>

Andrew, thanks for testing and great this also works on mips.

Anyone willing to take the patches for 3.18? Are any further acks
needed?

Thanks,

-Robert
