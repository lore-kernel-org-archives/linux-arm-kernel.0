From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Sep 2012 08:39:23 -0700
Subject: [PATCH v3 1/9] pinctrl: mvebu: pinctrl driver core
In-Reply-To: <1347266386-16229-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1345623750-10645-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347266386-16229-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347266386-16229-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkdah7h7YqenftcPgRtoS7RE3t47MnAkn9+ZAuF7P-vM4dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 1:39 AM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> This patch adds a pinctrl driver core for Marvell SoCs plus DT
> binding documentation. This core driver will be used by SoC family
> specific drivers, i.e. Armada XP, Armada 370, Dove, Kirkwood, aso.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> v2:
> - restructured Kconfig to have a common PINCTRL_MVEBU that are selected by
>   SoC specific drivers.
> - cleaned pinctrl-mvebu and replaced 'magic numbers' by defines
> - make use of of_iomap instead of get_resource/ioremap
> - extended include documentation and checked with scripts/kernel-doc
> - cleaned devicetree binding documentation
>
> v3:
> - list of functions is now built out of pin groups passed to core driver
>   instead of parsing DT node.

Looks good to me.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
