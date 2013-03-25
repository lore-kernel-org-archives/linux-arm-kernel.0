From: davem@davemloft.net (David Miller)
Date: Mon, 25 Mar 2013 12:15:22 -0400 (EDT)
Subject: [PATCH 1/1 net-next] net: fec: build fec.c and fec_ptp.c to
 one module
In-Reply-To: <1364173422-7865-1-git-send-email-Frank.Li@freescale.com>
References: <1364173422-7865-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20130325.121522.198735535139409128.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>
Date: Mon, 25 Mar 2013 09:03:42 +0800

> fec_ptp.ko can't run individually
> rename fec.c to fec_main.c
> Build fec.o and fec_ptp.o into one fec.ko
> Remove unnessary EXPORT_SYMBOL in fec_ptp
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>

Applied, thanks.
