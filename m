From: marex@denx.de (Marek Vasut)
Date: Wed, 10 Jul 2013 21:57:16 +0200
Subject: [PATCH 04/12] drivers/mmc/host: don't use
 devm_pinctrl_get_select_default() in probe
In-Reply-To: <1373471889-18107-4-git-send-email-wsa@the-dreams.de>
References: <1373471889-18107-1-git-send-email-wsa@the-dreams.de>
 <1373471889-18107-4-git-send-email-wsa@the-dreams.de>
Message-ID: <201307102157.16419.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Wolfram Sang,

> Since commit ab78029 (drivers/pinctrl: grab default handles from device
> core), we can rely on device core for setting the default pins. Compile
> tested only.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org> (personally at LCE13)
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Something like that is already in -next:

    mmc: mxs-mmc: Let device core handle pinctrl

Otherwise

Tested-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
