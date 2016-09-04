From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 4 Sep 2016 22:53:45 +0200
Subject: [PATCH 05/33] gpio: add generic single-register fixed-direction
 GPIO driver
In-Reply-To: <20160902170057.GE1041@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
 <E1beJjz-0000mA-0o@rmk-PC.armlinux.org.uk>
 <CACRpkdZJy9gZwH9__qXAf6nURN7xV6CbOaGC-JL6X5rDHN55VQ@mail.gmail.com>
 <20160830214253.GP1041@n2100.armlinux.org.uk>
 <CACRpkdbNn0VXf7bHcfAq2qe2WpiZUxO-HRvikh4nv-svgJf+pg@mail.gmail.com>
 <20160902170057.GE1041@n2100.armlinux.org.uk>
Message-ID: <CACRpkdYYvxmBn+gZnYb5ugK9m5nW2kdGuK8hJ3OjyBWgT-xi6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 2, 2016 at 7:00 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:

> Linus,
>
> There's a change I'd like to merge into patch 5 - overall it looks
> like the below, and allows us to use gpio-reg with the PXA mainstone
> MST_PCMCIA[01] registers.  Some of these GPIO signals have hardware
> interrupts associated with them, but not all.
>
> Do you approve?

Yes of course.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
