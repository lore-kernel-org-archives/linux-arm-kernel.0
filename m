From: jg1.han@samsung.com (Jingoo Han)
Date: Thu, 08 Nov 2012 09:44:02 +0900
Subject: [PATCH] ARM: cache-l2x0: move 'l2_wt_override' variable to proper
 place
In-Reply-To: <20121107093419.GS28327@n2100.arm.linux.org.uk>
References: <003f01cdbcad$a024c1e0$e06e45a0$%han@samsung.com>
 <20121107093419.GS28327@n2100.arm.linux.org.uk>
Message-ID: <001301cdbd4a$26193c30$724bb490$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 07, 2012 6:34 PM Russell King wrote
> 
> On Wed, Nov 07, 2012 at 03:03:36PM +0900, Jingoo Han wrote:
> > Fixed build warning as below:
> >
> > arch/arm/mm/cache-l2x0.c:37:12: warning: 'l2_wt_override' defined but not used [-Wunused-variable]
> 
> You're too late with this; it's already been resolved.

OK, I see. :)
