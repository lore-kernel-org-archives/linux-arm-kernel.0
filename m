From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 1 Jan 2012 15:14:36 +0100
Subject: [PATCH v3 1/3] pinctrl: enable pinmux for mmp series
In-Reply-To: <1324541855-19911-2-git-send-email-haojian.zhuang@marvell.com>
References: <1324541855-19911-1-git-send-email-haojian.zhuang@marvell.com>
 <1324541855-19911-2-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <CACRpkdbYyennCeRO3K4M-ya=svyxYD4Nuc9iQ5zDqWjzoZBQGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2011 at 9:17 AM, Haojian Zhuang
<haojian.zhuang@marvell.com> wrote:

> Support PXA168/PXA910/MMP2 pinmux. Now only support function switch.
(...)

> ?drivers/pinctrl/Kconfig ? ? ? ? ?| ? 22 +
> ?drivers/pinctrl/Makefile ? ? ? ? | ? ?4 +
> ?drivers/pinctrl/pinctrl-pxa3xx.c | ?244 +++++++++
> ?drivers/pinctrl/pinctrl-pxa3xx.h | ?264 ++++++++++
> ?drivers/pinctrl/pinmux-mmp2.c ? ?| ?723 +++++++++++++++++++++++++++
> ?drivers/pinctrl/pinmux-pxa168.c ?| ?652 ++++++++++++++++++++++++
> ?drivers/pinctrl/pinmux-pxa910.c ?| 1008 ++++++++++++++++++++++++++++++++++++++

As per earlier discussion, all files should be named pinctrl-* not pinmux-*.

Can you respin this quickly? I think it's looking good overall
and seems like a nice merge candidate. Remaining problems
can surely be fixed in-tree.

I am even attempted to merge this as it is and fix the renaming myself,
but prefer not to since I might screw something up.

Yours,
Linus Walleij
