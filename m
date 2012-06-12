From: tony@atomide.com (Tony Lindgren)
Date: Tue, 12 Jun 2012 00:04:31 -0700
Subject: [PATCH v7 04/12] ARM: SoC: convert OMAP4 to SoC descriptor
In-Reply-To: <1339085369-26073-5-git-send-email-marc.zyngier@arm.com>
References: <1339085369-26073-1-git-send-email-marc.zyngier@arm.com>
 <1339085369-26073-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <20120612070431.GF12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marc Zyngier <marc.zyngier@arm.com> [120607 09:21]:
> Convert OMAP4 to use the SoC descriptor to provide its SMP
> and CPU hotplug operations.
> 
> Tested on both Panda and IGEPv2 (MULTI_OMAP kernel)
> 
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

FYI, I got some whitespace error on the ux500 patch while
applying this series.

Gave this series a quick boot test on 2430/omap3/omap4
and it works just fine:

Tested-by: Tony Lindgren <tony@atomide.com>
