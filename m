From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Nov 2012 13:55:37 +0000
Subject: [PATCH] ARM: VIC: remove unused irq_base variable
In-Reply-To: <201211081340.54440.arnd@arndb.de>
References: <1350392786-29191-1-git-send-email-linus.walleij@stericsson.com>
 <201211081340.54440.arnd@arndb.de>
Message-ID: <20121108135537.GZ28327@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 08, 2012 at 01:40:54PM +0000, Arnd Bergmann wrote:
> "ARM: VIC: use irq_domain_add_simple()" causes a new warning:
> 
> arch/arm/common/vic.c: In function 'vic_of_init':
> arch/arm/common/vic.c:410:6: warning: unused variable 'irq_base' [-Wunused-variable]
> 
> Since the irq_base variable is not used any more, it should be
> removed now

I've just committed exactly the same patch to my tree...
