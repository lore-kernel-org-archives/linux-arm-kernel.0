From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 24 Feb 2011 17:27:52 +0530
Subject: [PATCH 0/3] OMAP2+: voltage: first pass at cleanup/reorganization
In-Reply-To: <20110221020231.7598.14024.stgit@twilight.localdomain>
References: <20110221020231.7598.14024.stgit@twilight.localdomain>
Message-ID: <553cd99ec29ee91e4a4b324d0f4a0be7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org
[mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf
> Of Paul Walmsley
> Sent: Monday, February 21, 2011 7:39 AM
> To: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Cc: khilman at ti.com; nm at ti.com; b-cousson at ti.com; mturquette at ti.com
> Subject: [PATCH 0/3] OMAP2+: voltage: first pass at
cleanup/reorganization
>
> Hello,
>
> this patch set does an initial round of cleanup on the OMAP "voltage"
code
> in arch/arm/mach-omap2/voltage.c.  As part of this process, the header
files
> for the voltage code and SmartReflex are moved into arch/arm/mach-omap2,
since
> they are currently OMAP2+-specific.
>
> There is still quite a bit of cleanup left to do; hopefully someone else
will
> get to it before I do.  More details are in the last patch.
>
> This series was built-tested for an OSK5912-specific config,
omap1_defconfig,
> a N800-specific config, omap2plus_defconfig, an OMAP3-specific config,
and
> an OMAP4-specific config.  It was boot-tested on an OMAP35xx
Beagleboard.
> Further testing assistance is, of course, appreciated.

I found these abort on my 4430SDP. The below changes I found
are needed for it to bootup..
I tested the 'integration-2.6.39' branch of
git://git.pwsan.com/linux-integration and the patch is
based on this branch.

---
