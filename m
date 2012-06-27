From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Wed, 27 Jun 2012 13:50:11 +0000
Subject: [PATCH] ARM: OMAP2+: cpu: Make cpu_class_is_omap2 true for all
 non-omap1 platforms
In-Reply-To: <20120627133950.GJ3483@atomide.com>
References: <1339420974-23695-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA5096A@DBDE01.ent.ti.com>
 <20120627133950.GJ3483@atomide.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EA5BAF8@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2012 at 19:09:50, Tony Lindgren wrote:
> * Hiremath, Vaibhav <hvaibhav@ti.com> [120614 07:37]:
> > On Mon, Jun 11, 2012 at 18:52:54, Hiremath, Vaibhav wrote:
> > > As omap1 and omap2 will never be compiled together, due to
> > > different compiler flags, so we can simply make
> > > cpu_class_is_omap2() = true, for all non-omap1 platforms.
> > > 
> > > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > > ---
> > >  arch/arm/plat-omap/include/plat/cpu.h |    3 +--
> > >  1 files changed, 1 insertions(+), 2 deletions(-)
> > > 
> > 
> > Tony,
> > 
> > Ping???
> 
> Thanks applying into devel-am33xx branch.
> 

Thanks Tony,

There are few cleanup patches pending for your review, it would be good if 
you provide your review comments.

Thanks,
Vaibhav
