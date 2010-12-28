From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 28 Dec 2010 02:17:42 +0100
Subject: [PATCH] TWD: enable one-shot mode
In-Reply-To: <20101224191855.GJ20587@n2100.arm.linux.org.uk>
References: <20101224191855.GJ20587@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinU+x2uV34SCO=p2K4z6BO_DSYy2+1BRU5eAgHO@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/24 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> Allow one shot timer mode to be used with the TWD. ?This allows
> NOHZ mode to be used on SMP systems using the TWD localtimer.
>
> Tested on Versatile Express.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> Acks/Tested-by's would be appreciated, thanks.

Tested on the U8500 and doesn't seem to break anything...

Local interrupts after a few minutes of use before patching
(and enabling NO_HZ):
LOC:       8203       8224

After patching;
LOC:        233        322

Looks like it's working, too.

Tested-by: Linus Walleij <linus.walleij@stericsson.com>

Yours,
Linus Walleij
