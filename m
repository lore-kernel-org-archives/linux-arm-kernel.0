From: davem@davemloft.net (David Miller)
Date: Mon, 15 Apr 2013 14:10:20 -0400 (EDT)
Subject: [PATCH] net/macb: fix error return code in macb_probe()
In-Reply-To: <1366013073-22934-1-git-send-email-nicolas.ferre@atmel.com>
References: <1366013073-22934-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20130415.141020.1721813812373854975.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Mon, 15 Apr 2013 10:04:33 +0200

> Fix to return a negative error code from the error handling
> case instead of 0, as returned elsewhere in this function.
> 
> Original-idea-by: <yongjun_wei@trendmicro.com.cn>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Applied.
