From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 1 Oct 2017 17:03:54 +0200
Subject: [PATCH v2 0/4] Make PL031 interrupt optional
In-Reply-To: <20170929102116.GX20805@n2100.armlinux.org.uk>
References: <20170929102116.GX20805@n2100.armlinux.org.uk>
Message-ID: <CACRpkdZ1-JFs0p-jO7YEb+A9MrxmLbkfu89G59VsaXvkvvu1xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 29, 2017 at 12:21 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:

> There are some boards out there which have a PL031 RTC, but its
> interrupt is not wired up.  To support these, we need the PL031
> to support the primecell without interrupts.
>
> When no interrupt is present, there's little point exposing the
> RTC's alarm capabilities, so we omit the alarm-related function
> calls - the RTC merely becomes a source of time-of-day.
>
> This patch series cleans up the pl031 driver a little, and adds
> support for this configuration.

This series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
