From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 8 Jun 2016 14:10:36 +0200
Subject: [PATCH] pinctrl: at91-pio4: fix non-exported functions
In-Reply-To: <1465319265-27630-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465319265-27630-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <CACRpkdbrCOaz-JRmgq7E6DvF-amJkkVj22R2dyg+bubz=qshig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 7, 2016 at 7:07 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:

> The atmel_pctl_find_group_by_pin() and the atmel_pinctrl_remove()
> functions are not exported, so fix the warnings about these
> being exported without definitions by making them static.
>
> drivers/pinctrl/pinctrl-at91-pio4.c:424:20: warning: symbol 'atmel_pctl_find_group_by_pin' was not declared. Should it be static?
> drivers/pinctrl/pinctrl-at91-pio4.c:1077:5: warning: symbol 'atmel_pinctrl_remove' was not declared. Should it be static?
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Patch applied with Ludovic's ACK.

Yours,
Linus Walleij
