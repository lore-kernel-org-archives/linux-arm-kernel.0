From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Jun 2016 08:50:45 +0200
Subject: [PATCH] pinctrl: nomadik: fix warnings from unexported functions
In-Reply-To: <1465402062-26122-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465402062-26122-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <CACRpkdavZ9hhrXKAd71_xt7bU6cPyHRynzJeWf+v+p3DMYhnNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 8, 2016 at 6:07 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:

> There are five functions in the driver that are defined but
> only used locally. Since these are not used in the current
> kernel, delete them to avoid the following warnings:
>
> drivers/pinctrl/nomadik/pinctrl-nomadik.c:1036:6: warning: symbol 'nmk_gpio_clocks_enable' was not declared. Should it be static?
> drivers/pinctrl/nomadik/pinctrl-nomadik.c:1050:6: warning: symbol 'nmk_gpio_clocks_disable' was not declared. Should it be static?
> drivers/pinctrl/nomadik/pinctrl-nomadik.c:1073:6: warning: symbol 'nmk_gpio_wakeups_suspend' was not declared. Should it be static?
> drivers/pinctrl/nomadik/pinctrl-nomadik.c:1094:6: warning: symbol 'nmk_gpio_wakeups_resume' was not declared. Should it be static?
> drivers/pinctrl/nomadik/pinctrl-nomadik.c:1120:6: warning: symbol 'nmk_gpio_read_pull' was not declared. Should it be static?
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alessandro Rubini <rubini@unipv.it>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-gpio at vger.kernel.org

Patch applied.

Yours,
Linus Walleij
