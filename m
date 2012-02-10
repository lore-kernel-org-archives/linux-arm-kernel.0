From: tony@atomide.com (Tony Lindgren)
Date: Fri, 10 Feb 2012 11:18:13 -0800
Subject: [PATCH 1/2] ARM: OMAP: Get rid of reset for system timer
In-Reply-To: <1328191435-18652-2-git-send-email-santosh.shilimkar@ti.com>
References: <1328191435-18652-1-git-send-email-santosh.shilimkar@ti.com>
 <1328191435-18652-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20120210191813.GU1426@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [120202 05:33]:
> From: Rajendra Nayak <rnayak@ti.com>
> 
> hwmod setup already does a reset and sets the OCP sysconfig
> registers appropriately. Avoid doing a reset again and overriding
> the OCP sysconfig settings in the system timer init code.

If we want this queued as a fix, it should also describe what
actually breaks? Timer? PM?

If this is regression, then it should also have the usuual
commit 123abc (blah blah blah) caused blah blah..

Regards,

Tony
