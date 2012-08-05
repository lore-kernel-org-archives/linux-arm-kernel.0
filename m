From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 5 Aug 2012 11:53:46 +0200
Subject: [RFC PATCH] gpio: Add a generic GPIO handling driver
In-Reply-To: <1340961676-25432-1-git-send-email-LW@KARO-electronics.de>
References: <1340961676-25432-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <CACRpkdbKxM5=2brx8S7WP6GQwGKuTSBcALOG-VTB_rgwnXNTUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2012 at 11:21 AM, Lothar Wa?mann <LW@karo-electronics.de> wrote:

> This driver provides an interface for device drivers that need to
> control some external hardware (e.g. reset or enable signals) for the
> devices they serve.

I sort of like the idea, but I want a solid use case, i.e. an indication
of platform using this, and patches in the works. So I want atleast
one more patch making real use of the mechanism, or we just
gain weight in the kernel for no use.

Also, the introduction message should be merged into
Documentation/gpio.txt so people can easily find it.

I'd ideally like Grant's feedback on this too, since it's a major thing.

Yours,
Linus Walleij
