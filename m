From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 Sep 2011 18:02:17 -0700
Subject: [PATCH v2 14/16] ARM: omap2/3: Add global
	omap2/3_intc_handle_irq() functions
In-Reply-To: <1317034955-1029-15-git-send-email-marc.zyngier@arm.com>
References: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
	<1317034955-1029-15-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110928010217.GV6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marc Zyngier <marc.zyngier@arm.com> [110926 07:02]:
> Provide the OMAP2/3 IRQ code with low level handlers that can be used
> by platforms using CONFIG_MULTI_IRQ_HANDLER. Though the handlers are
> written in C, the compiled code looks very similar to its assembly
> counterpart (at least with my gcc 4.4.1).
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Nice, thanks for doing this!

Tested-by: Tony Lindgren <tony@atomide.com>
