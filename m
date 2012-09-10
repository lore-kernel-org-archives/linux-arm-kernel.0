From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Sep 2012 08:45:30 -0700
Subject: [PATCH v3 0/9] pinctrl: mvebu: pinctrl driver
In-Reply-To: <1347266386-16229-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1345623750-10645-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347266386-16229-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkda0AxcwqeBy2rZXRymq5iYxbdYWQsHtALHMObYqTaKyKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 1:39 AM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> This patch set adds a core pinctrl driver for Marvell MVEBU SoCs and
> SoC specific stubs for Armada 370, Armada XP, Dove, and Kirkwood.
> The SoC specific stubs use the pinctrl-mvebu core driver that handles
> pinctrl API and register accesses for common pinctrl registers.

This all looks good now, will this be pushed through some ARM SoC
tree along with Marvell changes or do you want me to take it all
through the pinctrl tree?

Yours,
Linus Walleij
