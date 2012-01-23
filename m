From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Mon, 23 Jan 2012 16:31:00 +0400
Subject: [PATCH 1/1] i.MX SDMA: Fix burstsize settings
In-Reply-To: <1327315765-20679-1-git-send-email-philippe.retornaz@epfl.ch>
References: <20120123102501.GN5446@pengutronix.de>
 <1327315765-20679-1-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <4F1D5304.3080003@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 23-01-2012 14:49, Philippe R?tornaz wrote:

> Commit 6584cb88 fixed the mxcmmc driver but forgot to fix the

    Please also specify that commit's summary in parens. Russell has recently 
again explained why it's needed.

> SDMA driver to handle the correct burtsize.
> This make the SD card access works again with DMA on i.MX31 boards.

> Signed-off-by: Philippe R?tornaz<philippe.retornaz@epfl.ch>
> Tested-by: Sascha Hauer<s.hauer@pengutronix.de>
> Acked-by: Sascha Hauer<s.hauer@pengutronix.de>

WBR, Sergei
