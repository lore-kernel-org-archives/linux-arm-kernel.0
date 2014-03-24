From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 24 Mar 2014 10:39:32 +0530
Subject: [PATCH 08/62] ARM: davinci: use explicit 'select' for DA850_EVM
In-Reply-To: <201403211656.06007.arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-9-git-send-email-arnd@arndb.de> <532AE351.9000503@ti.com>
 <201403211656.06007.arnd@arndb.de>
Message-ID: <532FBE0C.2060903@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 March 2014 09:26 PM, Arnd Bergmann wrote:

> From 5eaf7fdfe7c831d3aa24428a6e8d4509ac160db6 Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Tue, 18 Feb 2014 12:23:19 +0100
> Subject: [PATCH] ARM: davinci: use explicit 'select' for DA850_EVM
> 
> The DAVINCI_DA850_EVM board uses an unusual method to
> enable the GPIO_PCA953X and KEYBOARD_GPIO_POLLED symbols,
> which leads to the dependencies on these symbols being
> ignored. As GPIO_PCA953X actually requires I2C, that
> can lead to build failures when I2C is disabled.
> 
> This patch removes the duplicate symbol definitions
> and instead enables them from the davinci_all_defconfig
> file.

> A different question whether we actually want to automatically
> enable them at all or rather put them into defconfig,
> but that should be a separate patch.

This para can be dropped now.

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: davinci-linux-open-source at linux.davincidsp.com

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
