From: tony@atomide.com (Tony Lindgren)
Date: Thu, 7 Jul 2011 17:32:16 +0300
Subject: [PATCH v8 04/14] ARM: omap4: use remapped PPI interrupts for
	local timer
In-Reply-To: <1309855755-6261-5-git-send-email-marc.zyngier@arm.com>
References: <1309855755-6261-1-git-send-email-marc.zyngier@arm.com>
	<1309855755-6261-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110707143213.GN15815@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marc Zyngier <marc.zyngier@arm.com> [110705 11:45]:
> Use the normal interrupt scheme for the local timers by using
> a remapped PPI interrupt.
> 
> Tested on a Pandaboard.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Tony Lindgren <tony@atomide.com>
