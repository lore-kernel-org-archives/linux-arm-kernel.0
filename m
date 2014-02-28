From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Feb 2014 10:31:39 +0100
Subject: [PATCH v2 2/7] ARM: mm: Remove unsed dma_to_virt()
In-Reply-To: <1393535872-20915-3-git-send-email-santosh.shilimkar@ti.com>
References: <1393535872-20915-1-git-send-email-santosh.shilimkar@ti.com>
 <1393535872-20915-3-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <11058924.lnYaaxnuom@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 February 2014 16:17:47 Santosh Shilimkar wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Remove dma_to_virt() as there are no in-tree users of it.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Greg Ungerer <gerg@uclinux.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
