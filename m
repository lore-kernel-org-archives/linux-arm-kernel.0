From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 8 Sep 2016 00:25:48 +0200
Subject: [PATCH 01/33] gpio: sa1100: fix irq probing for ucb1x00
In-Reply-To: <E1beJje-0000lm-Ei@rmk-PC.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
 <E1beJje-0000lm-Ei@rmk-PC.armlinux.org.uk>
Message-ID: <CACRpkdbuU4uE-OYNhK4Pk+nwQO2r9BW5m0cM_qGx6KrYTxQVsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 12:24 PM, Russell King
<rmk+kernel@armlinux.org.uk> wrote:

> ucb1x00 has used IRQ probing since it's dawn to find the GPIO interrupt
> that it's connected to.  However, commit 23393d49fb75 ("gpio: kill off
> set_irq_flags usage") broke this by disabling IRQ probing on GPIO
> interrupts.  Fix this.
>
> Fixes: 23393d49fb75 ("gpio: kill off set_irq_flags usage")
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Patch applied per Russell's request. Trying to get this tested
and upstream ASAP.

Yours,
Linus Walleij
