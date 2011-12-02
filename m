From: davem@davemloft.net (David Miller)
Date: Fri, 02 Dec 2011 12:58:32 -0500 (EST)
Subject: [PATCH v2] net/macb: add DT support
In-Reply-To: <1322847782-22650-1-git-send-email-nicolas.ferre@atmel.com>
References: <1322846050-4543-1-git-send-email-nicolas.ferre@atmel.com>
 <1322847782-22650-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20111202.125832.1208514279272697863.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Fri,  2 Dec 2011 18:43:02 +0100

> From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> 
> Allow the device tree to provide the mac address and the phy mode.
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> [nicolas.ferre at atmel.com: change "compatible" node property, doc and DT hwaddr]
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Jamie Iles <jamie@jamieiles.com>
> ---
> v2: modify macb_get_hwaddr_dt() parameter

You'll have to respin these two macb patches, as they don't apply properly
to the net-next tree which is where they should be targetted.

Thanks.
