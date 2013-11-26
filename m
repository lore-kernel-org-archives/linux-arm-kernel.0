From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 26 Nov 2013 22:43:41 +0100
Subject: STOP THE MADNESS
In-Reply-To: <20131126163031.GC16735@n2100.arm.linux.org.uk>
References: <20131126163031.GC16735@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdaEH532sE+mK-buh891zZP+uOqX4jjPUGO-sbGDKSgQVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 5:30 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Versatile PB926 is currently broken in mainline because of this, and it's
> damn obvious that people are just churning out changes to "update" drivers
> without testing them at all.

Incidentally I was actually testing this driver today for the other pl061
patches I sent - on the Integrator/AP with the IM-PD1 board.

Strangely I don't get this crash.

But I was wondering why my interrupts didn't fire properly and
now I'm starting to suspect it has something to do with this.

I'll revert and see if this fixes it...

Yours,
Linus Walleij
