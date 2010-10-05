From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 5 Oct 2010 17:20:01 +0200
Subject: [PATCH 4/4] dmaengine: Add Freescale i.MX1/21/27 DMA driver
In-Reply-To: <1285854995-6569-5-git-send-email-s.hauer@pengutronix.de>
References: <1285854995-6569-1-git-send-email-s.hauer@pengutronix.de>
	<1285854995-6569-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <AANLkTim+rs8-X7UGO1w6qGFe2ACzD8qkzu-mrww0Gt8c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/30 Sascha Hauer <s.hauer@pengutronix.de>:

> This driver is currently implemented as a user to the old i.MX
> DMA API. This allows us to convert each user of the old API to
> the dmaengine API one by one. Once this is done the old DMA
> driver can be merged into the i.MX dmaengine driver.

Seems like a nice path forward so FWIW
Acked-by: Linus Walleij <linus.walleij@stericsson.com>

Yours,
Linus Walleij
