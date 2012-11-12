From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Nov 2012 16:17:41 +0000
Subject: [PATCH v2 12/17] ARM: clps711x: autcpu12: Special driver for
 handling NAND memory is removed
In-Reply-To: <1352545136-29089-13-git-send-email-shc_work@mail.ru>
References: <1352545136-29089-1-git-send-email-shc_work@mail.ru>
 <1352545136-29089-13-git-send-email-shc_work@mail.ru>
Message-ID: <201211121617.41304.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 10 November 2012, Alexander Shiyan wrote:
> This patch provide migration to using "gpio-nand" and "basic-mmio-gpio"
> drivers instead of using special driver for handling NAND memory.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applying this patch fails to build because it requires "GENERIC_GPIO" to be
enabled in Kconfig, which is not enabled here.

	Arnd
