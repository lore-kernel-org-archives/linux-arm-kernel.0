From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 Mar 2016 22:47:30 +0700
Subject: [PATCH v4] drivers: pinctrl: add driver for Allwinner A64 SoC
In-Reply-To: <1457429879-19335-1-git-send-email-andre.przywara@arm.com>
References: <1457429879-19335-1-git-send-email-andre.przywara@arm.com>
Message-ID: <CACRpkdbUr8mk1Wmy66ZmsYAxgo8EVrABQ_KQYi_h-h0Kg2VFiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 8, 2016 at 4:37 PM, Andre Przywara <andre.przywara@arm.com> wrote:

> Based on the Allwinner A64 user manual and on the previous sunxi
> pinctrl drivers this introduces the pin multiplex assignments for
> the ARMv8 Allwinner A64 SoC.
> Port A is apparently used for the fixed function DRAM controller, so
> the ports start at B here (the manual mentions "n from 1 to 7", so
> not starting at 0).
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
