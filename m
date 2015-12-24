From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 Dec 2015 16:50:33 +0100
Subject: [PATCH 0/3] OMAP: RX51: save atags data to be exported on
 /proc/atags
In-Reply-To: <1450965658-2675-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1450965658-2675-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Message-ID: <201512241650.33737.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 December 2015, Ivaylo Dimitrov wrote:
> Nokia N900 legacy userspace needs ATAGS passed by the bootloder to be
> available in /proc/atags. With DT booted kernel this information is
> no longer availabe. Fix that by saving ATAGS data early in the boot 
> stage so it can be exported in /proc/atags later

Looks ok to me.

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
