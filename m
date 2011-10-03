From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 03 Oct 2011 09:59:35 +0300
Subject: [PATCH 03/30] video/omap: fix build dependencies
In-Reply-To: <1317566760-25681-4-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-4-git-send-email-arnd@arndb.de>
Message-ID: <1317625175.2026.8.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Sun, 2011-10-02 at 16:45 +0200, Arnd Bergmann wrote:
> Four of the LCD panel drivers depend on the backlight class,
> so add the dependency in Kconfig.
> Selecting the BACKLIGHT_CLASS_DEVICE symbol does not generally
> work since it has other dependencies.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

This looks ok to me. If it's fine to you, I'll queue this patch in my
DSS tree to prevent possible conflicts.

 Tomi
