From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 Feb 2016 16:52:24 +0100
Subject: [PATCH] ARM: realview: DT support for the PBA8
In-Reply-To: <56CDA0F0.9050608@arm.com>
References: <1456303714-31039-1-git-send-email-linus.walleij@linaro.org>
 <56CDA0F0.9050608@arm.com>
Message-ID: <CACRpkdbQKZxMgYRUq6cjAXHq5q1EufVwcHG=wJ0QsDcqUVoRhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2016 at 1:24 PM, Robin Murphy <robin.murphy@arm.com> wrote:

> And here I thought that big black box on the far corner of my desk was only
> good for taking up space. I have no idea of its provenance, but here's what
> it had to say (using appended dtb and a hack in the decompressor to set
> r1=-1, r2=0 because I can't be bothered faffing with a 2010-vintage u-boot):

Nice! Thanks!

> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at drivers/clk/versatile/clk-sp810.c:137

This noise is fixed in another separate patch I sent earlier:
http://permalink.gmane.org/gmane.linux.kernel.clk/4383

> Waiting for root device /dev/mmcblk0p1...
>
> It then fails to notice my SD card, even if I eject and reinsert it :(

Fixing a v2 as we speak.

Yours,
Linus Walleij
