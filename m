From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 6 Jul 2014 00:23:51 +0000 (UTC)
Subject: [PATCH 1/2] arm: dra7xx: Add hwmod data for pcie1 phy and pcie2
 phy
In-Reply-To: <1403719366-9656-2-git-send-email-kishon@ti.com>
References: <1403719366-9656-1-git-send-email-kishon@ti.com>
 <1403719366-9656-2-git-send-email-kishon@ti.com>
Message-ID: <alpine.DEB.2.02.1407060023330.23762@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Jun 2014, Kishon Vijay Abraham I wrote:

> Added hwmod data for pcie1 and pcie2 phy present in DRA7xx SOC.
> Also added the missing CLKCTRL OFFSET macro and CONTEXT OFFSET macro
> for pcie1 phy and pcie2 phy.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Tested-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks, queued for v3.17 with Rajendra's ack.


- Paul
