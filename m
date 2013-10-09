From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 Oct 2013 11:11:28 +0200
Subject: [PATCH 4/4] pinctrl: Enable pinctrl for Broadcom Capri SoCs
In-Reply-To: <1380846199-12829-5-git-send-email-syin@broadcom.com>
References: <1380846199-12829-1-git-send-email-syin@broadcom.com>
 <1380846199-12829-5-git-send-email-syin@broadcom.com>
Message-ID: <CACRpkdYj2MagpVGbA2k+B_NhhMUfXNpXQxBn1z1kxmTKCLZA4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 4, 2013 at 2:23 AM, Sherman Yin <syin@broadcom.com> wrote:

> Enable pinctrl for Broadcom Capri (BCM281xx) SoCs.
>
> Signed-off-by: Sherman Yin <syin@broadcom.com>
> Reviewed-by: Christian Daudt <bcm@fixthebug.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
(...)
> +       pinctrl at 35004800 {
> +               compatible = "brcm,capri-pinctrl";
> +               reg = <0x35004800 0x430>;
> +       };

What is the point of doing this without defining some pins
and connecting them to some devices?

Yours,
Linus Walleij
