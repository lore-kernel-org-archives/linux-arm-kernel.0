From: nsekhar@ti.com (Nori, Sekhar)
Date: Thu, 11 Aug 2011 03:51:02 +0530
Subject: [PATCH 08/19] mach-davinci: move DaVinci TNET GPIO driver to
	GPIO subsystem
In-Reply-To: <1312978639-18339-1-git-send-email-linus.walleij@stericsson.com>
References: <1312978639-18339-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024E04F945@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Wed, Aug 10, 2011 at 17:47:19, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> As per example from the other ARM boards, push the DaVinci TNET
> GPIO driver down to the GPIO subsystem so it can be consolidated.
> 
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

There should be no need of this since the TNETV107x
GPIO can simply be supported using the basic MMIO GPIO
driver. I submitted patches for that a while back
but have some comments from Grant to address. He requested
some changes to be done to the basic MMIO GPIO driver
itself.

https://lkml.org/lkml/2011/7/5/16

I do plan to rework those patches and post them back.

Thanks,
Sekhar
