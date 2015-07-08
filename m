From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 08 Jul 2015 16:44:29 +0200
Subject: [PATCH 1/2] ARM: ux500: define serial port aliases
In-Reply-To: <1436361307-27686-1-git-send-email-linus.walleij@linaro.org>
References: <1436361307-27686-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <2803757.Q7GidEKeB2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 July 2015 15:15:07 Linus Walleij wrote:
> This enumerates the PL011 serial ports on the Ux500. This is
> necessary to do if we want to remove one of the serial ports,
> since userspace depends on console to be present on ttyAMA2
> and we must not break userspace.
> 
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC guys: if you find this patch OK, please apply this
> directly for fixes, as a prerequisite for patch 2/2.
> 

I'd normally recommend putting the aliases into the per-board
file, to ensure that the labels on the board match the aliases.

	Arnd
