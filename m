From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 10 May 2012 17:02:11 -0600 (MDT)
Subject: [PATCH-V2 2/4] ARM: OMAP2+: CLEANUP: Move omap3 dpll ops to
 dpll3xxx.c
In-Reply-To: <1336506724-5494-3-git-send-email-hvaibhav@ti.com>
References: <1336506724-5494-1-git-send-email-hvaibhav@ti.com>
 <1336506724-5494-3-git-send-email-hvaibhav@ti.com>
Message-ID: <alpine.DEB.2.00.1205101701420.32719@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 May 2012, Vaibhav Hiremath wrote:

> In order to remove unnecessary idefs, move noncore and core
> dpll ops to dpll3xxx.c file (where it should have been already).
> 
> The clkops (clkops_omap3_core_dpll_ops & clkops_omap3_noncore_dpll_ops)
> is used in clock data files, and dependency is already handled by
> Makefile rule.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

This is probably okay.

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
