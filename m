From: khilman@ti.com (Kevin Hilman)
Date: Thu, 03 Mar 2011 17:41:19 -0800
Subject: [PATCH] omap3: cpuidle: Add description field to each C-state.
In-Reply-To: <1297437132-1005-2-git-send-email-santosh.shilimkar@ti.com>
References: <1297437132-1005-1-git-send-email-santosh.shilimkar@ti.com>
	<1297437132-1005-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1299202879.3989.499.camel@vence>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-02-11 at 20:42 +0530, Santosh Shilimkar wrote:
> Add a description field to each idle C-state. This helps to give
> better data with PowerTop and one don't have to refer to the code
> to link what Cx means from system point of view while analysing
> PowerTop data.
> 
> No functional change.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>

Looks good, queuing for 2.6.39 (branch: for_2.6.39/pm-misc)

Kevin
