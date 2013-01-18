From: davem@davemloft.net (David Miller)
Date: Fri, 18 Jan 2013 14:16:26 -0500 (EST)
Subject: [PATCH v3 1/1 net-next] net: fec: enable pause frame to
 improve rx prefomance for 1G network
In-Reply-To: <1358391358-27977-1-git-send-email-Frank.Li@freescale.com>
References: <1358391358-27977-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20130118.141626.1543157230023121224.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>
Date: Thu, 17 Jan 2013 10:55:58 +0800

> The limition of imx6 internal bus cause fec can't achieve 1G perfomance.
> There will be many packages lost because FIFO over run.
> 
> This patch enable pause frame flow control.
 ...
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> Signed-off-by: Fugang Duan <B38611@freescale.com>

Applied.
