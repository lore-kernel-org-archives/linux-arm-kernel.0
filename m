From: tony@atomide.com (Tony Lindgren)
Date: Thu, 21 Jul 2016 23:41:02 -0700
Subject: [PATCH 1/3] ARM: mach-omap2: remove bogus "or_module" from
 rx51-peripherals
In-Reply-To: <20160720041332.30789-2-paul.gortmaker@windriver.com>
References: <20160720041332.30789-1-paul.gortmaker@windriver.com>
 <20160720041332.30789-2-paul.gortmaker@windriver.com>
Message-ID: <20160722064101.GW28140@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Paul Gortmaker <paul.gortmaker@windriver.com> [160719 21:17]:
> During unrelated work, attempting to remove an include of the
> linux/module.h in favour of "struct module;" in order to reduce
> header entanglement, we found doing so caused a build failure in
> this file.

We're planning to drop this file after v4.8-rc1 after I've
verified that legacy booting still works at v4.8-rc1.

Are you OK if I pick this patch into my omap-for-v4.8/legacy
branch? Or if you have a minimal immutable branch against v4.7-rc1
with just this patch I can merge it in no problem.

Regards,

Tony
