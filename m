From: davem@davemloft.net (David Miller)
Date: Sun, 01 Apr 2012 16:17:14 -0400 (EDT)
Subject: [PATCH] net: lpc_eth: Fix rename of dev_hw_addr_random
In-Reply-To: <1332974186-12962-1-git-send-email-stigge@antcom.de>
References: <1332974186-12962-1-git-send-email-stigge@antcom.de>
Message-ID: <20120401.161714.1988118567020406881.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roland Stigge <stigge@antcom.de>
Date: Thu, 29 Mar 2012 00:36:26 +0200

> In parallel to the integration of lpc_eth.c, dev_hw_addr_random() has been
> renamed to eth_hw_addr_random(). This patch fixes it also in the new driver
> lpc_eth.c.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Applied and queued up for -stable.
