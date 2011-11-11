From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 Nov 2011 19:46:41 +0100
Subject: [PATCH 39/41] ARM: restart: lpc32xx & u300: remove unnecessary
 printk
In-Reply-To: <E1RN6u6-0001ZD-Ll@rmk-PC.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6u6-0001ZD-Ll@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkda9mC6+WrbGekJD85X4t7AsuamhP5V=YcyNQLFw0Yii7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 6, 2011 at 6:53 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Remove the:
> ? ? ? ?KERN_CRIT "RESET: Rebooting system\n" (lpc32xx)
> ? ? ? ?KERN_CRIT "RESET: shutting down/rebooting system\n" (u300)
>
> printk from the restart handler; we already print such a message from
> kernel_restart() in kernel/sys.c:
>
> ? ? ? ?KERN_EMERG "Restarting system.\n"
>
> so this is unnecessary.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks Russell,
Linus Walleij
