From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Mar 2015 11:16:55 +0100
Subject: [PATCH v6 5/8] pinctrl: Cygnus: define Broadcom Cygnus
 GPIO/PINCONF binding
In-Reply-To: <1425933902-20652-6-git-send-email-rjui@broadcom.com>
References: <1425933902-20652-1-git-send-email-rjui@broadcom.com>
 <1425933902-20652-6-git-send-email-rjui@broadcom.com>
Message-ID: <CACRpkdYFfZ+SGJyzOZTHPtVfGZmXgUGqpTNTKWOWuGTHNWSmDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 9, 2015 at 9:44 PM, Ray Jui <rjui@broadcom.com> wrote:

> Document the GPIO/PINCONF device tree binding for Broadcom Cygnus SoC
>
> Signed-off-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>

Patch applied!

> +- compatible:
> +    Must be "brcm,cygnus-ccm-gpio", "brcm,cygnus-asiu-gpio", or
> +    "brcm,cygnus-crmu-gpio"

Thanks for making this change. It is very useful because it can now handle
any other variant-specific quirks you may run into.

Yours,
Linus Walleij
