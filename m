From: tony@atomide.com (Tony Lindgren)
Date: Fri, 20 Jan 2012 04:43:03 -0800
Subject: [PATCH v4 05/15] ARM: OMAP4: convert to
 twd_local_timer_register() interface
In-Reply-To: <1327061042-14857-6-git-send-email-marc.zyngier@arm.com>
References: <1327061042-14857-1-git-send-email-marc.zyngier@arm.com>
 <1327061042-14857-6-git-send-email-marc.zyngier@arm.com>
Message-ID: <20120120124302.GK22818@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marc Zyngier <marc.zyngier@arm.com> [120120 03:31]:
> Add support for the new smp_twd runtime registration interface
> to the OMAP4 platforms, and remove the old compile-time support.
> Tested on Panda.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Tony Lindgren <tony@atomide.com>
