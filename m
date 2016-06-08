From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 8 Jun 2016 14:06:37 +0200
Subject: [PATCH] pinctrl: nsp-gpio: fix non-static functions
In-Reply-To: <1465318695-23348-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465318695-23348-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <CACRpkdbFHnvigLtEB+2kQmX79+mrrHKCSYcmjSdKkm-asEfd3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 7, 2016 at 6:58 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:

> Fixup warnings from functions that are not exported and
> therefore should be marked static. Fixes:
>
> drivers/pinctrl/bcm/pinctrl-nsp-gpio.c:461:5: warning: symbol 'nsp_pin_config_group_get' was not declared. Should it be static?
> drivers/pinctrl/bcm/pinctrl-nsp-gpio.c:467:5: warning: symbol 'nsp_pin_config_group_set' was not declared. Should it be static?
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Patch applied for fixes with Ray's ACK.

Yours,
Linus Walleij
