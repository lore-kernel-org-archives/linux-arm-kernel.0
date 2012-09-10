From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Sep 2012 08:43:18 -0700
Subject: [PATCH v3 4/9] pinctrl: mvebu: add pinctrl driver for Armada 370
In-Reply-To: <1347266386-16229-5-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1345623750-10645-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347266386-16229-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347266386-16229-5-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkdZ-Lw5V3knNaAfsvrrPqNoYezKTj6sCafjG_6mK35+szA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 1:39 AM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>
> This pinctrl driver is not a full-blown pinctrl driver from scratch:
> it relies on the common pinctrl-mvebu driver, which is used for all
> Marvell EBU SoCs.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> v2:
> - removed arch/arm/*/Kconfig changes and added note about variant = 0

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
