From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 4 May 2012 22:03:40 +0200
Subject: Making ARM multiplatform kernels DT-only?
In-Reply-To: <20120504143518.GF26481@n2100.arm.linux.org.uk>
References: <201205031350.35476.arnd@arndb.de>
 <CAK2p4sJj7FRVSStVkqmn16sUv8S3vHmUYCU_VzTWAWzqV5yVsg@mail.gmail.com>
 <20120504142057.GQ27023@stoneboat.aleph1.co.uk>
 <20120504143518.GF26481@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdZ3m=PXg35==3wo2xHPL7TRn1W0AX_CeMKjPd1U+pTAGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 4, 2012 at 4:35 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Well, my understanding is that there's DT patches around for Versatile.

Is there? There is some in-tree stuff, but haven't seen any other
sign of patches.

Having looked a bit at that I get the impression that this DT code has
been developed (by Grant I guess) in QEMU only as a proof of concept,
and never really tested on a real Versatile hardware unit.

These:
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7390/1
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7391/1

make it clear that noone ever tested an MMC card on a Versatile
booted on real hardware using DT. And I strongly suspect there
are more instances like that, it seems AACI, GPIO and I2C and
I guess whatever you cannot test on QEMU is just unsupported.

But maybe the majority of Versatile users are on QEMU anyway,
I sometimes get that impression :-/

Yours,
Linus Walleij
