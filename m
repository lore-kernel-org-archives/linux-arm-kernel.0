From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 21 Dec 2010 15:30:27 -0700 (MST)
Subject: [PATCH 3/3] OMAP: wd_timer: remove old, dead probing code
In-Reply-To: <20101116102518.27991.38133.stgit@twilight.localdomain>
References: <20101116102205.27991.37909.stgit@twilight.localdomain>
	<20101116102518.27991.38133.stgit@twilight.localdomain>
Message-ID: <alpine.DEB.2.00.1012211529440.1446@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 16 Nov 2010, Paul Walmsley wrote:

> After commit f2ce62312650211f6cf665cd6dc519c334c4071e, watchdog
> probing is handled by files in mach-omap1/ and mach-omap2/, and the
> plat-omap/devices.c probing code is no longer used.  Remove the dead
> code in plat-omap/devices.c.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Charulatha Varadarajan <charu@ti.com>

Dropping this patch since Tony merged Anand Gadiyar's fix for the same 
issue dated 3 December 2010.


- Paul
