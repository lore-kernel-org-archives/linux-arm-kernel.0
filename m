From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 Mar 2016 09:59:48 +0700
Subject: [PATCH 1/8] drivers/pinctrl: sunxi/pinctrl-sunxi.c does not need
 module.h
In-Reply-To: <1456778924-20730-2-git-send-email-paul.gortmaker@windriver.com>
References: <1456778924-20730-1-git-send-email-paul.gortmaker@windriver.com>
 <1456778924-20730-2-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <CACRpkdZ0_qmkyfBOBwXFL-HV+PvQxz-Emv0qiMv7EaEJaR1BkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 1, 2016 at 3:48 AM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:

> This file is not modular, nor is it using modular functions. The
> only thing close is the global THIS_MODULE which comes from export.h
> so lets replace it appropriately and cut back on the amount of
> header stuff we draw in by several thousand lines.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: linux-gpio at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
