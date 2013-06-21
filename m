From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jun 2013 23:41:08 +0200
Subject: [PATCH] ARM: keystone: remove hand-coded smc instruction
In-Reply-To: <51C4C3B4.2050508@ti.com>
References: <201306212228.29717.arnd@arndb.de>
 <201306212313.16771.arnd@arndb.de> <51C4C3B4.2050508@ti.com>
Message-ID: <201306212341.08579.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 June 2013, Santosh Shilimkar wrote:
> > 
> I was curious how you will fix that for a c file.
> Just to be clear, I was planning to do that in 3.11-rcx/3.12
> time. Let me know if it needs to be done earlier than that.

It breaks randconfig builds on arm-soc at the moment, so I'd
like the fix as early as possible for 3.11.

	Arnd
