From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 03 Oct 2011 10:36:43 +0530
Subject: [PATCH 06/30] ARM: omap: fix build with CONFIG_I2C_OMAP disabled
In-Reply-To: <1317566760-25681-7-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-7-git-send-email-arnd@arndb.de>
Message-ID: <4E8942E3.2030507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 02 October 2011 08:15 PM, Arnd Bergmann wrote:
> We must not reference omap_i2c_reset if the file defining it
> does not get built.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
