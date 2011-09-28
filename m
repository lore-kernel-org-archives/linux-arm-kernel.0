From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 Sep 2011 18:04:36 -0700
Subject: [PATCH v2 16/16] ARM: GIC: Make MULTI_IRQ_HANDLER mandatory
In-Reply-To: <1317034955-1029-17-git-send-email-marc.zyngier@arm.com>
References: <1317034955-1029-1-git-send-email-marc.zyngier@arm.com>
	<1317034955-1029-17-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110928010436.GX6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marc Zyngier <marc.zyngier@arm.com> [110926 03:35]:
> Now that MULTI_IRQ_HANDLER is selected by all the in-tree
> GIC users, make it mandatory and remove the unused macros.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Tested-by: Tony Lindgren <tony@atomide.com>
