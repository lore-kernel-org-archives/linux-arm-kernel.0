From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 26 May 2011 09:41:06 +0200
Subject: [RFC PATCH v3 1/2] drivers/amba: create devices from device tree
In-Reply-To: <1306359073-16274-2-git-send-email-robherring2@gmail.com>
References: <1306359073-16274-1-git-send-email-robherring2@gmail.com>
	<1306359073-16274-2-git-send-email-robherring2@gmail.com>
Message-ID: <BANLkTimq=6UGTHVL=r2GQZJaKMBH7X6wqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/25 Rob Herring <robherring2@gmail.com>:

Trivia:

> + ? ? ? /* Allow the arm,amba-deviceid value to override the h/w value */
> + ? ? ? prop = of_get_property(node, "arm,amba-deviceid", NULL);
> + ? ? ? if (prop)
> + ? ? ? ? ? ? ? dev->periphid = of_read_ulong(prop, 1);

That currently does not override the H/W value at all. But when/if patch
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6829/1
gets merged, it eventually will.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
