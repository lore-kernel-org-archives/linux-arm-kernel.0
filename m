From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Apr 2018 15:59:20 +0200
Subject: [PATCH] ARM: Assume maintainership of ARM reference designs
In-Reply-To: <20180412135201.GH16141@n2100.armlinux.org.uk>
References: <20180412131426.18011-1-linus.walleij@linaro.org>
 <20180412131737.GF16141@n2100.armlinux.org.uk>
 <20180412131845.GG16141@n2100.armlinux.org.uk>
 <CACRpkdaKc28xe1_iBd07qRsGig_yc0Kfm+ZRj8+t+Wd32uMK7w@mail.gmail.com>
 <20180412135201.GH16141@n2100.armlinux.org.uk>
Message-ID: <CACRpkdaL13zAOa1YQuWx+Y=2jCT6NfB60g_Dxg5mVp7NebY_Yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2018 at 3:52 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:

> I do have several boards - mainly a few varieties of Integrator CP
> (including one with a stack of FPGA tiles containing bitstreams for
> various development CPUs) - eg, ARM926 based SMP system which was
> never merged into mainline.  Versatile PB926 and Realview EB.
> The PB926 partly runs my test farm here.

OK make sure to poke me with something sharp if I break any of them.
I try to double- and tripletest them on hardware and QEMU alike but
I don't have all variants.

>  The Versatile Express
> CT9x4 is still part of the boot farm, and just about works with
> certain kernels, but I'm pretty sure there's a cache latency bug
> there (I carry patches privately to fix it, but it doesn't appear to
> completely solve it.)

So there is a bug in it! I thought it was only my board.
And yeah, I also suspect the cache, that is my intuitive suspicion
with this kind of random early hangs (I did try to get some earlyprintk
on it but it didn't give anything useful, just hard hang).

I have been rebooting and swearing about that one in my office
everytime it just hangs.

Yours,
Linus Walleij
