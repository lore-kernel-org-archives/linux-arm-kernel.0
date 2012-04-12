From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Apr 2012 18:06:02 +0000
Subject: [PATCH v3] ARM: ux500: core U9540 support
In-Reply-To: <1334251434-15154-1-git-send-email-linus.walleij@stericsson.com>
References: <1334251434-15154-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <201204121806.03180.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 April 2012, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This adds support for the U9540 variant of the U8500 series. This
> is an application processor without internal modem. This is the
> most basic part with ASIC ID, CPU-related fixes, IRQ list, register
> ranges, timer, UART, and L2 cache setup. This is based on a patch
> by Michel Jaouen which was rewritten to fit with the latest 3.3
> kernel.
> 
> ChangeLog v1->v2: deleted the irqs-db9540.h file since we expect to
>   migrate to using Device Tree for getting the IRQs to devices.
> ChangeLog v2->v3: introduced a fixed virtual offset for the ROM
>   as suggested by Arnd Bergmann.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Sebastien Pasdeloup <sebastien.pasdeloup-nonst@stericsson.com>
> Signed-off-by: Michel Jaouen <michel.jaouen@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
