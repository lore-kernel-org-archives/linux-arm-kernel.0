From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 Aug 2012 10:12:31 +0200
Subject: [PATCH 00/11] pinctrl: mvebu: pinctrl driver
In-Reply-To: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkdZn73M_5rciZhpTTidMpwfMSZqb+wZnY5FkgztK2YBFiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 11, 2012 at 2:56 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> This patch set adds a core pinctrl driver for Marvell MVEBU SoCs and
> SoC specific stubs for Armada 370, Armada XP, Dove, and Kirkwood.
> The SoC specific stubs use the pinctrl-mvebu core driver that handles
> pinctrl API and register accesses for common pinctrl registers.

Nice! I'll now go in and review it.

Please add Stephen Warren <swarren@wwwdotorg.org> on CC for
subsequent iterations.

Yours,
Linus Walleij
