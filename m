From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 Aug 2012 16:11:35 +0200
Subject: [PATCH 01/11] pinctrl: mvebu: pinctrl driver core
In-Reply-To: <1344689809-6223-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1344689809-6223-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkdZvjLx4+2CpgOemwWVfyFjFbRe-pzZbwAjExqHhQqBOjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 11, 2012 at 2:56 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> This patch adds a pinctrl driver core for Marvell SoCs plus DT
> binding documentation. This core driver will be used by SoC family
> specific drivers, i.e. Armada XP, Armada 370, Dove, Kirkwood, aso.
(...)
> +config PINCTRL_MVEBU
> +       bool "Marvell SoC pin controller drivers"
> +       depends on ARCH_MVEBU

So altering earlier statements I suspect this should be simply:

depends on PLAT_ORION

Yours,
Linus Walleij
