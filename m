From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 03 Oct 2011 10:37:35 +0530
Subject: [PATCH 05/30] ARM: omap: enable building omap2 without
	omap2420/2430
In-Reply-To: <1317566760-25681-6-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-6-git-send-email-arnd@arndb.de>
Message-ID: <4E894317.6040003@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 02 October 2011 08:15 PM, Arnd Bergmann wrote:
> Kconfig allows selecting CONFIG_OMAP2 but no specific SOC, the options
> being omap2420 and omap2430, but that leads to a build error when
> omap3 or omap4 are also enabled and the MULTI_OMAP2 symbol is
> undefined.
> 
> This adds another clause to plat/multi.h, mainly to allow all
> possible randconfig combinations to build cleanly.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
