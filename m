From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 Oct 2013 10:55:27 +0200
Subject: [PATCH 1/4] pinctrl: Add void * to pinctrl_pin_desc
In-Reply-To: <1380846199-12829-2-git-send-email-syin@broadcom.com>
References: <1380846199-12829-1-git-send-email-syin@broadcom.com>
 <1380846199-12829-2-git-send-email-syin@broadcom.com>
Message-ID: <CACRpkdaMODd9=fZPC+-FMJ1tWw95DBGjsu4DEzKqrNhGpYSARA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 4, 2013 at 2:23 AM, Sherman Yin <syin@broadcom.com> wrote:

> drv_data is added to the pinctrl_pin_desc for drivers to define additional
> driver-specific per-pin data.
>
> Signed-off-by: Sherman Yin <syin@broadcom.com>
> Reviewed-by: Christian Daudt <bcm@fixthebug.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> ---
> Change-Id: I78b2c44b93d88b04897fd0af80ffce213e338d6b

Why are you giving me this funky Gerrit stuff along with the patch?
It's not like I have any use for it, and anything below the three
dashes will be deleted when applying.

The patch is OK but won't be applied until some driver is
using it (i.e. this BRCM one...)

Yours,
Linus Walleij
