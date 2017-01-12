From: tony@atomide.com (Tony Lindgren)
Date: Thu, 12 Jan 2017 14:28:28 -0800
Subject: [PATCH] ARM: dts: am335x-phycore-som: Remove partition tables
In-Reply-To: <1483951050-46588-1-git-send-email-t.remmet@phytec.de>
References: <1483951050-46588-1-git-send-email-t.remmet@phytec.de>
Message-ID: <20170112222827.GO2630@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Teresa Remmet <t.remmet@phytec.de> [170109 00:38]:
> As the bootloader passes the NAND and the SPI flash partition tables
> there is no need to keep them in the kernel device tree.
> Removed them.
> 
> Signed-off-by: Teresa Remmet <t.remmet@phytec.de>

Applying into omap-for-v4.11/dt thanks.

Tony
