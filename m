From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 23 Jan 2014 09:17:08 +0100
Subject: [PATCH] pinctrl: Rename Broadcom Capri pinctrl driver
In-Reply-To: <1390343886-25852-1-git-send-email-syin@broadcom.com>
References: <1390343886-25852-1-git-send-email-syin@broadcom.com>
Message-ID: <CACRpkdZ+3MC8XpfD-vumvq3yQACzFn89DQjWQeXbdBK+9JmfLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 11:38 PM, Sherman Yin <syin@broadcom.com> wrote:

> To be consistent with other Broadcom drivers, the Broadcom Capri pinctrl
> driver and its related CONFIG option are renamed to bcm281xx.
>
> Devicetree compatible string and binding documentation use
> "brcm,bcm11351-pinctrl" to match the machine binding here:
> Documentation/devicetree/bindings/arm/bcm/bcm11351.txt
>
> This driver supports pinctrl on BCM11130, BCM11140, BCM11351, BCM28145
> and BCM28155 SoCs.
>
> Signed-off-by: Sherman Yin <syin@broadcom.com>
> Reviewed-by: Matt Porter <mporter@linaro.org>

Patch applied for fixes.

If it was only the DT bindings that were rushed to change
you *could* have made a patch just changing these and the
binding doc, and give me the option to defer the changing of
variables and function names, but whatever.

Yours,
Linus Walleij
