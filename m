From: tony@atomide.com (Tony Lindgren)
Date: Mon, 26 Feb 2018 13:25:15 -0800
Subject: [PATCH] ARM: omap2: set CONFIG_LIRC=y in defconfig
In-Reply-To: <20180226204105.2858838-1-arnd@arndb.de>
References: <20180226204105.2858838-1-arnd@arndb.de>
Message-ID: <20180226212344.GA16043@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [180226 20:42]:
> The CONFIG_LIRC symbol has changed from 'tristate' to 'bool, so we now
> get a warning for omap2plus_defconfig:
> 
> arch/arm/configs/omap2plus_defconfig:322:warning: symbol value 'm' invalid for LIRC
> 
> This changes the file to mark the symbol as built-in to get rid of the
> warning.
> 
> Fixes: a60d64b15c20 ("media: lirc: lirc interface should not be a raw decoder")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Tony Lindgren <tony@atomide.com>
