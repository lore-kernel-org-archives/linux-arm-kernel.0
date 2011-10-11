From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 11 Oct 2011 21:51:28 +0200
Subject: [PATCH v3 6/7] ARM: pxa: move gpio-pxa.h into include directory
In-Reply-To: <1318339051-19096-7-git-send-email-haojian.zhuang@marvell.com>
References: <1318339051-19096-1-git-send-email-haojian.zhuang@marvell.com>
	<1318339051-19096-7-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <CAKnu2Mr3cWfo3SJYkBU2cXeKELhmVOv+Qes=SCWRBaSB-Sue3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/11 Haojian Zhuang <haojian.zhuang@marvell.com>:

> Merge the gpio-pxa.h in arch-pxa and arch-mmp. Move the new gpio-pxa.h
> into include directory.
(...)
> ?arch/arm/plat-pxa/include/plat/gpio-pxa.h ?| ? 80 ---------------------------
> ?drivers/gpio/gpio-pxa.c ? ? ? ? ? ? ? ? ? ?| ? 42 ++++++++++++++-
> ?include/linux/gpio-pxa.h ? ? ? ? ? ? ? ? ? | ? 81 ++++++++++++++++++++++++++++

This seems like a fully valid merge of common pxa GPIO include
files. And I guess if both are not using plat-pxa it cannot reside
in <plat/gpio-pxa.h>?

Grant: shall this be <linux/gpio-pxa.h> or <linux/gpio/pxa.h> or so?

Yours,
Linus Walleij
