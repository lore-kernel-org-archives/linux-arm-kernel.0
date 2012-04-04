From: davem@davemloft.net (David Miller)
Date: Wed, 04 Apr 2012 04:39:52 -0400 (EDT)
Subject: [PATCH v3 3/8] net: Add device tree support to LPC32xx
In-Reply-To: <1333528480-17134-4-git-send-email-stigge@antcom.de>
References: <1333528480-17134-1-git-send-email-stigge@antcom.de>
 <1333528480-17134-4-git-send-email-stigge@antcom.de>
Message-ID: <20120404.043952.1333187975072018080.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roland Stigge <stigge@antcom.de>
Date: Wed,  4 Apr 2012 10:34:35 +0200

> This patch adds device tree support for lpc_eth.c.
> 
> The runtime option for MII/RMII is solved via the "phy-mode" property, SRAM
> ("IRAM") usage for DMA can be chosen via "use-iram".
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Feel free to merge this in via one of the ARM trees.

Acked-by: David S. Miller <davem@davemloft.net>
