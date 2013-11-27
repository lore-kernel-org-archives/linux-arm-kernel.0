From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Nov 2013 08:44:33 +0100
Subject: STOP THE MADNESS
In-Reply-To: <52954966.8030706@linaro.org>
References: <20131126163031.GC16735@n2100.arm.linux.org.uk>
 <CAL_Jsq+AYEN2GQxgkN5a+eJsC-80n9y6Y9JngpZN7FzbLGdENw@mail.gmail.com>
 <CACRpkdY9MTUDtDxRKRHCXch98cNiMS-dumQvaTH7gp1OCVUx6w@mail.gmail.com>
 <52954966.8030706@linaro.org>
Message-ID: <CACRpkdbE2djza8BbcT9i_tF-Wieb9X7BPkUaHhEjo4sNgrZHGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 2:22 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Does qemu support the board that Russell is using? If so, we can fix & test
> it.

Yes and no. It is versatilepb, but the GPIOs are not emulated. However
the device is there I think, and as this is a pure logical problem it
*should* have the same problem.

Which makes the crash even more strange, as people would have
noticed a probe failure like this in QEMU (the versatilepb QEMU model
is used a *lot*) but they didn't. Neither did it turn up on my real HW
IM-PD1.

I'll propse a patch, I'm still struggling with getting the PB I have up and
running ...

Yours,
Linus Walleij
