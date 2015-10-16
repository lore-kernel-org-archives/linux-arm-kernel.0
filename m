From: tony@atomide.com (Tony Lindgren)
Date: Fri, 16 Oct 2015 14:29:58 -0700
Subject: [PATCH] clocksource: ti-32k: make it depend on GENERIC_CLOCKSOURCE
In-Reply-To: <1445029805-13736-1-git-send-email-balbi@ti.com>
References: <201510170412.4siQMwFD%fengguang.wu@intel.com>
 <1445029805-13736-1-git-send-email-balbi@ti.com>
Message-ID: <20151016212958.GG24370@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [151016 14:17]:
> the new ti 32k clocksource driver should depend on
> GENERIC_CLOCKSOURCE because of its reliance on
> sched_clock_register().
> 
> Let's enable that to avoid any possible build errors
> and/or warnings on randbuilds.

Thanks applying this on omap-for-v4.4/soc.

Tony
