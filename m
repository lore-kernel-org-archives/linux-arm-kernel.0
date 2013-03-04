From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 4 Mar 2013 20:34:43 +0000
Subject: Latest randconfig build errors
In-Reply-To: <20130304095136.GI17833@n2100.arm.linux.org.uk>
References: <20130304095136.GI17833@n2100.arm.linux.org.uk>
Message-ID: <201303042034.43833.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 March 2013, Russell King - ARM Linux wrote:

> Versatile randconfig:
> 
> ERROR: "irq_domain_add_simple" [drivers/gpio/gpio-em.ko] undefined!
> 

I'm pretty sure I submitted a patch for this one before. I'll go looking
for it. IIRC the solution was to export that symbol.

	Arnd
