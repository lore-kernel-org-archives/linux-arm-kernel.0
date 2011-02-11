From: jhnikula@gmail.com (Jarkko Nikula)
Date: Fri, 11 Feb 2011 19:07:23 +0200
Subject: [PATCH] omap3: cpuidle: Add description field to each C-state.
In-Reply-To: <1297437132-1005-2-git-send-email-santosh.shilimkar@ti.com>
References: <1297437132-1005-1-git-send-email-santosh.shilimkar@ti.com>
	<1297437132-1005-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20110211190723.b93bcb60.jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Feb 2011 20:42:12 +0530
Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:

> Add a description field to each idle C-state. This helps to give
> better data with PowerTop and one don't have to refer to the code
> to link what Cx means from system point of view while analysing
> PowerTop data.
> 
> No functional change.
> 
Out of curiosity what powertop version is required to get these handy
descriptions visible?

As I see these in /sys/devices/system/cpu/cpu0/cpuidle/stateX/desc it's
fair to give my tested by

Tested-by: Jarkko Nikula <jhnikula@gmail.com>
