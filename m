From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 16 Jan 2014 14:24:07 +0100
Subject: [PATCH v4 2/4] pinctrl: Add pinctrl binding for Broadcom Capri
 SoCs
In-Reply-To: <1387592016-13740-3-git-send-email-syin@broadcom.com>
References: <1386787041-6035-1-git-send-email-syin@broadcom.com>
 <1387592016-13740-1-git-send-email-syin@broadcom.com>
 <1387592016-13740-3-git-send-email-syin@broadcom.com>
Message-ID: <CACRpkdYKrGFpK3Y46-9ah_ssaf-Y6O=O9Usqsw72gjorMKGYNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 21, 2013 at 3:13 AM, Sherman Yin <syin@broadcom.com> wrote:

> Adds pinctrl driver devicetree binding for Broadcom Capri (BCM281xx) SoCs.
>
> Signed-off-by: Sherman Yin <syin@broadcom.com>
> Reviewed-by: Christian Daudt <bcm@fixthebug.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> ---
> v4: Changed valid values for "bias-pull-up" property for I2C pins.  Expanded
>     pin configuration node example.

Patch applied with Mark R's ACK and a copy of his ECG.

Yours,
Linus Walleij
