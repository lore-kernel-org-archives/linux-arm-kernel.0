From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 08 Jul 2011 16:21:43 +0900
Subject: [PATCH V2 3/8] ARM: EXYNOS4: Add support PM with external GIC
References: <1309485457-13305-1-git-send-email-kgene.kim@samsung.com>
	<1309485457-13305-4-git-send-email-kgene.kim@samsung.com>
	<20110701212144.GF21898@n2100.arm.linux.org.uk>
Message-ID: <002a01cc3d3f$b1eff9b0$15cfed10$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> Russell King - ARM Linux wrote:
> >
> > Why not fix arch/arm/common/gic.c to save and restore the GIC state
> > itself?
> >
> Sorry I missed that. I saw "ARM: gic: Use cpu pm notifiers to save gic
state" by
> Colin Cross just now so will follow that up for supporting Samsung SoCs
which
> use GIC.
> 
Hi Russell,

We tested this with Colin's "ARM: gic: Use cpu pm notifiers to save gic
state" and it works fine.
So right now we don't need to add some stuff of GIC in common but I'm not
sure how it was going on...

Anyway how do you think that firstly I apply these into -next? If this
commit is not required will rebase(to remove existing save/restore GIC)
before pull request.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
