From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 03 Oct 2011 10:38:27 +0530
Subject: [PATCH 07/30] ARM: omap: fix visibility of omap2_mbox_iva_priv
In-Reply-To: <1317566760-25681-8-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-8-git-send-email-arnd@arndb.de>
Message-ID: <4E89434B.2040503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 02 October 2011 08:15 PM, Arnd Bergmann wrote:
> map2_mbox_iva_priv is used on multiple omap2 socs but is hidden
> in an outdated #ifdef that is specific to a single soc.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
