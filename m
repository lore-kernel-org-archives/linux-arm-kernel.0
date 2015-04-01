From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 01 Apr 2015 11:05:45 +0200
Subject: [PATCH v4 06/15] drivers: reset: Add STM32 reset driver
In-Reply-To: <1427819096-31109-7-git-send-email-mcoquelin.stm32@gmail.com>
References: <1427819096-31109-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1427819096-31109-7-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1427879145.3638.2.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 31.03.2015, 18:24 +0200 schrieb Maxime Coquelin:
> The STM32 MCUs family IPs can be reset by accessing some registers
> from the RCC block.
> 
> The list of available reset lines is documented in the DT bindings.
> 
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
