From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 Dec 2016 10:00:16 +0100
Subject: [PATCH 6/6] ARM64: dts: marvell: armada37xx: add pinctrl
 definition
In-Reply-To: <20161222172501.16121-7-gregory.clement@free-electrons.com>
References: <20161222172501.16121-1-gregory.clement@free-electrons.com>
 <20161222172501.16121-7-gregory.clement@free-electrons.com>
Message-ID: <CACRpkdZwAY-1c+ZkDhrWn-pov6OX3idHNzC6Kq86oit9cL3SeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2016 at 6:25 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> Start to populate the device tree of the Armada 37xx with the pincontrol
> configuration used on the board providing a dts.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

>  arch/arm64/boot/dts/marvell/armada-3720-db.dts |  8 +++++++

Maybe you want to take this opportunity to add gpio-line-names = ...;
to the armada 3720 pinctrl/gpiochip nodes?

Yours,
Linus Walleij
