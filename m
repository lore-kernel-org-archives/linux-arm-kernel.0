From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 May 2012 10:56:01 +0200
Subject: [PATCH 09/15] drivers/mfd: Enable Device Tree support for the
 db8500-prcmu
In-Reply-To: <1336155805-18554-10-git-send-email-lee.jones@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-10-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYdBufhd07fGeYSibyheoHfu68Hfrnsrpomd557mZAupA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 4, 2012 at 8:23 PM, Lee Jones <lee.jones@linaro.org> wrote:

> This patch will enable probing to occur during a Device Tree enabled
> boot. The IRQ base is expected to be located in and will be fetched
> from the DT itself. We also prevent any of the db8500 regulators
> from being registered here, as they will be enabled via DT instead.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
