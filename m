From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 Aug 2012 16:27:05 +0200
Subject: [PATCH 06/11] ARM: mvebu: add pinctrl device in DT for Armada
 370/XP SoCs
In-Reply-To: <1344689809-6223-7-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1344689809-6223-7-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <CACRpkdaWKf2se6PE7SMoOoqbTCLaMBMgjKbJa5tpQzr-RTSmJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 11, 2012 at 2:56 PM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:

> From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>
> The Armada 370 and XP SoCs have configurable muxing for a certain
> number of their pins, controlled through a pinctrl driver.
>
> The 'compatible' property is defined in the SoC-specific .dtsi files,
> since the compatible string identifies the number of pins and other
> SoC-specific properties.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

FWIW:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
