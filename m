From: tony@atomide.com (Tony Lindgren)
Date: Tue, 8 Oct 2013 14:31:30 -0700
Subject: [PATCH] ARM: OMAP5: id: Remove ES1.0 support
In-Reply-To: <5239B3B1.5000004@ti.com>
References: <5239AE35.8030406@ti.com>
 <1379513142-11125-1-git-send-email-nm@ti.com>
 <5239B3B1.5000004@ti.com>
Message-ID: <20131008213129.GT8313@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130918 07:15]:
> On Wednesday 18 September 2013 10:05 AM, Nishanth Menon wrote:
> > OMAP5 ES1.0 was intended as a test chip and has major register level
> > differences w.r.t ES2.0 revision of the chip. All register defines,
> > dts support has been solely added for ES2.0 version of the chip.
> > Further, all ES1.0 chips and platforms are supposed to have been
> > removed from circulation. Hence, there is no need to further retain
> > any resemblence of ES1.0 support in id detection code.
> > 
> > Remove the omap_revision handling and BUG() instead to prevent folks
> > who mistakenly try an older unsupported chip and report bogus errors.
> > 
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> > ref: http://marc.info/?l=linux-omap&m=137951198232339&w=2
> > based on 3.12-rc1 tag
> > 
> That was quick ...
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Heh, it was made, but not supposed to be used, and still merged
to mainline kernel..

I guess this is the way to deal with this issue as we don't have
really any omap5 es1 support in place. So applying into
omap-for-v3.13/soc branch.

Tony
