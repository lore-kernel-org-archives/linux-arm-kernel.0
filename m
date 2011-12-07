From: davem@davemloft.net (David Miller)
Date: Wed, 07 Dec 2011 13:27:39 -0500 (EST)
Subject: [PATCH v3 1/2] net/macb: add DT support for Cadence macb/gem
 driver
In-Reply-To: <714ca7492d8d45b50eab34448c4b70933ce5701c.1323086095.git.nicolas.ferre@atmel.com>
References: <1322847782-22650-1-git-send-email-nicolas.ferre@atmel.com>
 <714ca7492d8d45b50eab34448c4b70933ce5701c.1323086095.git.nicolas.ferre@atmel.com>
Message-ID: <20111207.132739.335219058075173468.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Mon,  5 Dec 2011 12:59:52 +0100

> From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> 
> Allow the device tree to provide the mac address and the phy mode.
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> [nicolas.ferre at atmel.com: change "compatible" node property, doc and DT hwaddr]
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> [jamie at jamieiles.com: add "gem" compatibility strings and doc]
> Acked-by: Jamie Iles<jamie@jamieiles.com>

Acked-by: David S. Miller <davem@davemloft.net>
