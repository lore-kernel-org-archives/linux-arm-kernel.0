From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 12 Jul 2015 23:02:52 +0200
Subject: [PATCH 1/2] ARM: ux500: define serial port aliases
In-Reply-To: <1436520735-23692-1-git-send-email-linus.walleij@linaro.org>
References: <1436520735-23692-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <4229513.CS60qBeWmX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 10 July 2015 11:32:15 Linus Walleij wrote:
> This enumerates the PL011 serial ports on the Ux500. This is
> necessary to do if we want to remove one of the serial ports,
> since userspace depends on console to be present on ttyAMA2
> and we must not break userspace.
> 
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Moved the alias definitions from the core SoC file
>   to the toplevel DTS file, as requested by Arnd.
> 
> 

Do all of the boards expose all three uarts in the same order?

	Arnd
