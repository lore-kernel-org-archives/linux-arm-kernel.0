From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 Sep 2011 18:01:34 -0700
Subject: [PATCH v2 03/16] ARM: GIC: Add global gic_handle_irq() function
In-Reply-To: <1317034955-1029-4-git-send-email-marc.zyngier@arm.com>
References: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
	<1317034955-1029-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110928010134.GU6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marc Zyngier <marc.zyngier@arm.com> [110926 03:33]:
> Provide the GIC code with a low level handler that can be used
> by platforms using CONFIG_MULTI_IRQ_HANDLER. Though the handler is
> written in C, the compiled code doesn't feel much slower than its
> assembly counterpart (at least with my gcc 4.4.1).
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Tested-by: Tony Lindgren <tony@atomide.com>
