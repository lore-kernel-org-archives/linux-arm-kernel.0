From: davem@davemloft.net (David Miller)
Date: Mon, 09 May 2016 15:06:34 -0400 (EDT)
Subject: [RESEND PATCH v6 0/6] Add Ethernet support on STM32F429
In-Reply-To: <1462789899-13153-1-git-send-email-alexandre.torgue@gmail.com>
References: <1462789899-13153-1-git-send-email-alexandre.torgue@gmail.com>
Message-ID: <20160509.150634.213732321950308841.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexandre TORGUE <alexandre.torgue@gmail.com>
Date: Mon,  9 May 2016 12:31:33 +0200

> STM32F429 Chip embeds a Synopsys 3.50a MAC IP.
> This series:
>  -enhance current stmmac driver to control it (code already
> available) and adds basic glue for STM32F429 chip.
>  -Enable basic Net config in kernel.

I assume this will go via the ARM tree, for the networking bits:

Acked-by: David S. Miller <davem@davemloft.net>
