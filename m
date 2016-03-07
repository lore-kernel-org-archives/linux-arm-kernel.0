From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Mar 2016 10:33:35 +0700
Subject: [PATCH v3 04/10] drivers: pinctrl: add driver for Allwinner A64
 SoC
In-Reply-To: <1456165255-31013-5-git-send-email-andre.przywara@arm.com>
References: <1456165255-31013-1-git-send-email-andre.przywara@arm.com>
 <1456165255-31013-5-git-send-email-andre.przywara@arm.com>
Message-ID: <CACRpkdYo+DhXd+7zQwnkXHPVYieE1r21Taib77SkW_sKd_Rmqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2016 at 1:20 AM, Andre Przywara <andre.przywara@arm.com> wrote:

> Based on the Allwinner A64 user manual and on the previous sunxi
> pinctrl drivers this introduces the pin multiplex assignments for
> the ARMv8 Allwinner A64 SoC.
> Port A is apparently used for the fixed function DRAM controller, so
> the ports start at B here (the manual mentions "n from 1 to 7", so
> not starting at 0).
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Rob Herring <robh@kernel.org>

Add Maxime's ACK.

This does not apply do the pinctrl devel branch, so please rebase it.

>  .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +
>  arch/arm64/Kconfig.platforms                       |   1 +

Remove this from the patch, it can go in through the ASoC or ARM64 tree,
just a symbol dependence is fine to merge orthogonally.

Yours,
Linus Walleij
