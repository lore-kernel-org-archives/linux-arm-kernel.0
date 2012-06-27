From: tony@atomide.com (Tony Lindgren)
Date: Wed, 27 Jun 2012 06:39:50 -0700
Subject: [PATCH] ARM: OMAP2+: cpu: Make cpu_class_is_omap2 true for all
 non-omap1 platforms
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA5096A@DBDE01.ent.ti.com>
References: <1339420974-23695-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA5096A@DBDE01.ent.ti.com>
Message-ID: <20120627133950.GJ3483@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Hiremath, Vaibhav <hvaibhav@ti.com> [120614 07:37]:
> On Mon, Jun 11, 2012 at 18:52:54, Hiremath, Vaibhav wrote:
> > As omap1 and omap2 will never be compiled together, due to
> > different compiler flags, so we can simply make
> > cpu_class_is_omap2() = true, for all non-omap1 platforms.
> > 
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > ---
> >  arch/arm/plat-omap/include/plat/cpu.h |    3 +--
> >  1 files changed, 1 insertions(+), 2 deletions(-)
> > 
> 
> Tony,
> 
> Ping???

Thanks applying into devel-am33xx branch.

Tony
