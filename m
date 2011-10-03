From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 03 Oct 2011 10:59:00 +0530
Subject: [PATCH 27/30] ARM: omap: select L2X0 cache on omap4
In-Reply-To: <1317566760-25681-28-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-28-git-send-email-arnd@arndb.de>
Message-ID: <4E89481C.4070405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 02 October 2011 08:15 PM, Arnd Bergmann wrote:
> The cache controller needs to be enabled for the
> cortex-a9 specific errata that are also selected
> to work.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>	
