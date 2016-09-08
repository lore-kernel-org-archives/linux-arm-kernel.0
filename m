From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Sep 2016 09:58:07 +0200
Subject: [PATCH 1/2] ARM: lpc32xx: remove unused header file mach/irqs.h
In-Reply-To: <1473303609-20076-1-git-send-email-vz@mleia.com>
References: <1473303609-20076-1-git-send-email-vz@mleia.com>
Message-ID: <4384334.zRRuiCemSt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 8, 2016 6:00:08 AM CEST Vladimir Zapolskiy wrote:
> The removed LPC32xx mach/irqs.h file is not included in any source
> code, function declaration lpc32xx_init_irq() is also unused, remove
> them as leftovers after switching to a new interrupt controller
> driver.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>

Good catch!

Both patches

Acked-by: Arnd Bergmann <arnd@arndb.de>
