From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 16 Jan 2014 14:19:11 +0100
Subject: [PATCH v4 3/4] ARM: pinctrl: Add Broadcom Capri pinctrl driver
In-Reply-To: <1387592016-13740-4-git-send-email-syin@broadcom.com>
References: <1386787041-6035-1-git-send-email-syin@broadcom.com>
 <1387592016-13740-1-git-send-email-syin@broadcom.com>
 <1387592016-13740-4-git-send-email-syin@broadcom.com>
Message-ID: <CACRpkdaPZrR=kEknr3YKDWLd_E+o22Yn19ei7iT6cdbYdbeZ2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 21, 2013 at 3:13 AM, Sherman Yin <syin@broadcom.com> wrote:

'> Adds pinctrl driver for Broadcom Capri (BCM281xx) SoCs.
>
> Signed-off-by: Sherman Yin <syin@broadcom.com>
> Reviewed-by: Christian Daudt <bcm@fixthebug.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> ---
> v4: - PINCTRL selected in Kconfig, PINCTRL_CAPRI selected in bcm_defconfig
>     - make use of regmap
>     - change CAPRI_PIN_UPDATE from macro to inline function.
>     - Handle pull-up strength arg in Ohm instead of enum

Patch applied. It is really good now! It's late before the merge
window, but you've done a tremendous work on this driver and
I don't want to delay its deployment further.

But note:

>  arch/arm/configs/bcm_defconfig  |    1 +
>  arch/arm/mach-bcm/Kconfig       |    1 +

I've optimistically applied these two hunks of the patch as well,
but if there is any conflict with the ARM SoC tree I will just rebase
the patch and pull these *out*.

ARM SoC maintainers: be warned if something collides.

Yours,
Linus Walleij
