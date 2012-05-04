From: kiko@linaro.org (Christian Robottom Reis)
Date: Fri, 4 May 2012 17:42:07 -0300
Subject: Making ARM multiplatform kernels DT-only?
In-Reply-To: <CACRpkdZ3m=PXg35==3wo2xHPL7TRn1W0AX_CeMKjPd1U+pTAGQ@mail.gmail.com>
References: <201205031350.35476.arnd@arndb.de>
 <CAK2p4sJj7FRVSStVkqmn16sUv8S3vHmUYCU_VzTWAWzqV5yVsg@mail.gmail.com>
 <20120504142057.GQ27023@stoneboat.aleph1.co.uk>
 <20120504143518.GF26481@n2100.arm.linux.org.uk>
 <CACRpkdZ3m=PXg35==3wo2xHPL7TRn1W0AX_CeMKjPd1U+pTAGQ@mail.gmail.com>
Message-ID: <20120504204207.GA11715@async.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2012 at 10:03:40PM +0200, Linus Walleij wrote:
> On Fri, May 4, 2012 at 4:35 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> > Well, my understanding is that there's DT patches around for Versatile.
> 
> Is there? There is some in-tree stuff, but haven't seen any other
> sign of patches.
> 
> Having looked a bit at that I get the impression that this DT code has
> been developed (by Grant I guess) in QEMU only as a proof of concept,
> and never really tested on a real Versatile hardware unit.
> 
> These:
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7390/1
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7391/1
> 
> make it clear that noone ever tested an MMC card on a Versatile
> booted on real hardware using DT. And I strongly suspect there
> are more instances like that, it seems AACI, GPIO and I2C and
> I guess whatever you cannot test on QEMU is just unsupported.

Isn't there work by Pawel that adds support for more of the Versatile
platform? My quick searching finds at least:

    http://comments.gmane.org/gmane.linux.drivers.i2c/10143
    http://comments.gmane.org/gmane.linux.ports.arm.kernel/143523

I think the latter is merged already, but I may be wrong.
-- 
Christian Robottom Reis, Engineering VP
Brazil (GMT-3) | [+55] 16 9112 6430 | [+1] 612 216 4935
Linaro.org: Open Source Software for ARM SoCs
