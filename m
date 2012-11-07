From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Nov 2012 09:34:19 +0000
Subject: [PATCH] ARM: cache-l2x0: move 'l2_wt_override' variable to
 proper place
In-Reply-To: <003f01cdbcad$a024c1e0$e06e45a0$%han@samsung.com>
References: <003f01cdbcad$a024c1e0$e06e45a0$%han@samsung.com>
Message-ID: <20121107093419.GS28327@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2012 at 03:03:36PM +0900, Jingoo Han wrote:
> Fixed build warning as below:
> 
> arch/arm/mm/cache-l2x0.c:37:12: warning: 'l2_wt_override' defined but not used [-Wunused-variable]

You're too late with this; it's already been resolved.
