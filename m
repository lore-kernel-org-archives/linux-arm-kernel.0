From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 14 Dec 2010 13:05:16 +0100
Subject: [PATCH] dmaengine: at_hdmac: fix buffer transfer size
	specification
In-Reply-To: <1292244521-20756-1-git-send-email-nicolas.ferre@atmel.com>
References: <1292244521-20756-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20101214120516.GN19897@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13:48 Mon 13 Dec     , Nicolas Ferre wrote:
> Buffer transfer size is the number of transfers to be performed in
> relation with the width of the _source_ interface.
> So in the DMA_FROM_DEVICE case, it should be the register width that
> should be taken into account.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
