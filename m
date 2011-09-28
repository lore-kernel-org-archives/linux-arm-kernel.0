From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 Sep 2011 18:01:15 -0700
Subject: [PATCH v2 02/16] ARM: smp: Add an IPI handler callable from C code
In-Reply-To: <1317034955-1029-3-git-send-email-marc.zyngier@arm.com>
References: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
	<1317034955-1029-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110928010115.GT6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marc Zyngier <marc.zyngier@arm.com> [110926 03:33]:
> In order to be able to handle IPI directly from C code instead of
> assembly code, introduce handle_IPI(), which is modeled after handle_IRQ().
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Tested-by: Tony Lindgren <tony@atomide.com>
