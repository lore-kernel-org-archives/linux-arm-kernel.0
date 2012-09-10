From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Sep 2012 08:42:13 -0700
Subject: [PATCH v3 3/9] pinctrl: mvebu: kirkwood pinctrl driver
In-Reply-To: <1347266386-16229-4-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1345623750-10645-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347266386-16229-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347266386-16229-4-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkdZnce_9yNOwpg91F39-uXmLK+Fg6rmaRk_Sy20UEshvGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 1:39 AM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> This patch adds a SoC specific pinctrl driver for Marvell Kirkwood SoCs
> plus DT binding documentation. This driver will use the mvebu pinctrl
> driver core.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> v2:
> - restructured pinctrl/Kconfig to hide pinctrl driver as it will be
>   always selected by arch/arm/mach-mvebu/Kconfig
> - use enum for kirkwood variants instead of defines
>
> v3:
> - moved variant specific data to DT match struct

Lookin' good.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
