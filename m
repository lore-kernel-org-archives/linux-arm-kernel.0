From: olof@lixom.net (Olof Johansson)
Date: Tue, 14 Jul 2015 11:15:51 +0200
Subject: [PATCH 1/2] ARM: ux500: define serial port aliases
In-Reply-To: <1436520735-23692-1-git-send-email-linus.walleij@linaro.org>
References: <1436520735-23692-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20150714091551.GA20686@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 10, 2015 at 11:32:15AM +0200, Linus Walleij wrote:
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
> ARM SoC guys: if you find this patch OK, please apply this
> directly for fixes, as a prerequisite for patch 2/2, then
> apply 2/2.

Thanks, applied.

-Olof
