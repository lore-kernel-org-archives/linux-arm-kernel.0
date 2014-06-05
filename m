From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 05 Jun 2014 22:22:51 +0200
Subject: keystone breakage
In-Reply-To: <5390C38C.9050606@ti.com>
References: <20140605183223.GF23430@n2100.arm.linux.org.uk>
 <5390C38C.9050606@ti.com>
Message-ID: <11000860.cdiKf5JsLi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 June 2014 15:22:52 Santosh Shilimkar wrote:
> On Thursday 05 June 2014 02:32 PM, Russell King - ARM Linux wrote:

> Thanks for reporting the issue. So far neither Laura's series nor my
> series is showing up in Linus's tip so I couldn't see the
> breakage myself but patch at the end of the email should fix
> the breakage.
> 
> Arnd, Olof,
> Will you be able to pick up the below fix from this email ?
> If you prefer, I can send the same after rc1 is tagged.
> 
> 
> From 661e238f98171082a7b080720b837283551ff80d Mon Sep 17 00:00:00 2001
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Date: Thu, 5 Jun 2014 14:51:33 -0400
> Subject: [PATCH] ARM: keystone: Drop use of meminfo since its not available
>  anymore
> 
> Laura's series removed the meminfo structure and its no longer available.
> Update keystone code to remove the usage of it.
> 
> Reported-by: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Applied on top of next/soc2, thanks a lot!

	Arnd
