From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Sep 2012 08:43:50 -0700
Subject: [PATCH v3 5/9] pinctrl: mvebu: add pinctrl driver for Armada XP
In-Reply-To: <1347266386-16229-6-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1345623750-10645-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347266386-16229-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347266386-16229-6-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkdY7HpW_DCUfQtcZ9MuKTRmc9B1Ja67GcftFszOkRK_KFA@mail.gmail.com>
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
> v2: replaced variant with enum and used bitops.h

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
