From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Feb 2014 15:35:13 +0100
Subject: [PATCH v2] arm/smp: Absorb boot_secondary()
In-Reply-To: <1393247328-23163-1-git-send-email-geert@linux-m68k.org>
References: <1393247328-23163-1-git-send-email-geert@linux-m68k.org>
Message-ID: <201402241535.13873.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 February 2014, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> 
> After becoming a mandatory function, boot_secondary() is no longer used
> outside arch/arm/kernel/smp.c. Hence remove its public prototype, and,
> as suggested by Arnd, let it be absorbed by its single caller.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
