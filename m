From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 7 May 2011 20:05:47 +0200
Subject: [PATCH 2/2] dmaengine: at_hdmac: implement pause and resume in
	atc_control
In-Reply-To: <47964dd140b0d36db6979f6cd945212ae566e60a.1304532833.git.nicolas.ferre@atmel.com>
References: <f4341d4672a23a958398b75cb4305e0e680f2e32.1304532833.git.nicolas.ferre@atmel.com>
	<47964dd140b0d36db6979f6cd945212ae566e60a.1304532833.git.nicolas.ferre@atmel.com>
Message-ID: <BANLkTi=tVoFLgnVUpj6pXOVN4ACsPed2bQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/4 Nicolas Ferre <nicolas.ferre@atmel.com>:

> Pause and resume controls are useful for audio devices. This also returns
> correct status from atc_tx_status() in case chan is paused.
>
> Idea from dw_dmac patch by Linus Walleij.
>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Looks good 2 me!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
