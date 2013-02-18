From: davem@davemloft.net (David Miller)
Date: Mon, 18 Feb 2013 14:52:27 -0500 (EST)
Subject: [PATCH v3 net-next 1/1] drivers: net: davinci_cpdma:
 acknowledge interrupt properly
In-Reply-To: <1361175560-600-1-git-send-email-mugunthanvnm@ti.com>
References: <1361175560-600-1-git-send-email-mugunthanvnm@ti.com>
Message-ID: <20130218.145227.706561380327970223.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mugunthan V N <mugunthanvnm@ti.com>
Date: Mon, 18 Feb 2013 13:49:20 +0530

> CPDMA interrupts are not properly acknowledged which leads to interrupt
> storm, only cpdma interrupt 0 is acknowledged in Davinci CPDMA driver.
> Changed cpdma_ctlr_eoi api to acknowledge 1 and 2 interrupts which are
> used for rx and tx respectively.
> 
> Reported-by: Pantelis Antoniou <panto@antoniou-consulting.com>
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>

Applied, thanks.
