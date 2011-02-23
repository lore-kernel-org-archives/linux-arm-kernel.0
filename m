From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 Feb 2011 11:12:57 -0800
Subject: [PATCH 0/8] OMAP2+: hwmod/clockevent: allow late-init of
	individual hwmods
In-Reply-To: <20110223070455.5874.51326.stgit@twilight.localdomain>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
Message-ID: <20110223191256.GB15225@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [110222 23:11]:
> Hello,
> 
> This series adds the ability to late-initialize individual
> hwmods.  The goal here is for clockevent (and eventually
> clocksource) hwmods to be late-initialized individually, and
> right before they are needed, in the timer init code.  Then
> omap_hwmod_late_init(), which late-inits the rest of the hwmods,
> is intended to run as an initcall -- much later in the boot
> process.

Sounds good to me!

Tony
