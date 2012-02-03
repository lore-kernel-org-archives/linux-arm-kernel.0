From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Feb 2012 16:13:43 +0000
Subject: [PATCH 02/13] ARM: SAMSUNG: allow the configuration of KERNEL
 HZ in plat-samsung
In-Reply-To: <016f01ccdc95$30279500$9076bf00$%kim@samsung.com>
References: <016f01ccdc95$30279500$9076bf00$%kim@samsung.com>
Message-ID: <20120203161343.GN889@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2012 at 10:44:20AM +0900, Kukjin Kim wrote:
> 
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

This patch really needs some kind of explanation.  It's far from obvious
from the casual reader why moving from a fixed value of 200Hz for the
kernel tick rate to a range from 32 to 1024 would be legal.

If 100Hz was possible before, and that's the architecture default, why
was 200Hz chosen instead?

And is 99Hz and 101Hz allowable?
