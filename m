From: tony@atomide.com (Tony Lindgren)
Date: Tue, 16 Oct 2012 14:02:25 -0700
Subject: [PATCH 09.5/16] mmc: omap: Remove cpu_is_omap usage from the
 driver
In-Reply-To: <87ipaog4mp.fsf@octavius.laptop.org>
References: <20121004213950.26676.21898.stgit@muffinssi.local>
 <20121004220454.26676.10131.stgit@muffinssi.local>
 <20121005180840.GN3874@atomide.com>
 <87ipaog4mp.fsf@octavius.laptop.org>
Message-ID: <20121016210225.GK15569@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Chris Ball <cjb@laptop.org> [121005 11:24]:
> On Fri, Oct 05 2012, Tony Lindgren wrote:
> >
> > Chris, I can set up a minimal immutable branch with omap
> > header changes that you can also pull into MMC tree if these
> > two MMC patches look ackable to you.
> 
> Thanks, sounds good.

Chris, I've now pushed out branch omap-for-v3.8/cleanup-headers-mmc
based on -rc1. The branch is located at:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git

It contains two omap MMC related patches that you can also merge
into the MMC tree if needed as now include plat/mmc.h is gone for
omaps.

Regards,

Tony
