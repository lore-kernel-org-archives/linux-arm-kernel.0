From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Sep 2011 10:59:54 +0200
Subject: [RFC] Shrink sched_clock some more
In-Reply-To: <20110922153611.GC8072@n2100.arm.linux.org.uk>
References: <20110922153611.GC8072@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdb1p7boHaf2evVcC9cPiwigKAdtyFJrjFO1T=d67X1-Ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2011 at 5:36 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> ... by getting rid of the fixed-constant optimization, and moving the
> update code into arch/arm/kernel/sched_clock.c.
>
> Platforms now only have to supply a function to read the sched_clock
> register, and some basic information such as the number of significant
> bits and the tick rate.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

I really like the looks of this patch!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
