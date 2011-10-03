From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 03 Oct 2011 11:01:49 +0530
Subject: [PATCH 30/30] ARM: omap2: select ARM_AMBA for OMAP3_EMU
In-Reply-To: <1317566760-25681-31-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-31-git-send-email-arnd@arndb.de>
Message-ID: <4E8948C5.6080301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 02 October 2011 08:16 PM, Arnd Bergmann wrote:
> OMAP3_EMU needs OC_ETM, which needs ARM_AMBA. Since the latter
> dependency is getting turned from a 'select' into a 'depends',
> omap has to select ARM_AMBA itself in order to have a correct
> dependency chain. Alternatively, we could change OMAP3_EMU
> to have a 'depends on OC_ETM' instead of selecting it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
