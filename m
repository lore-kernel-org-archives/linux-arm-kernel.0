From: davem@davemloft.net (David Miller)
Date: Thu, 07 Feb 2013 23:36:59 -0500 (EST)
Subject: [PATCH v3 1/2 net-next] net: fec: correct fix method about
 miss init spinlock
In-Reply-To: <1360198799-25173-1-git-send-email-Frank.Li@freescale.com>
References: <1360198799-25173-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20130207.233659.807881034629000930.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>
Date: Thu, 7 Feb 2013 08:59:58 +0800

> Old method will cause init spinlock twice.
> New method will avoid init spinlock twice and fix miss init spinlock
> at fec_restart.
 ...
> Signed-off-by: Frank Li <Frank.Li@freescale.com>

Applied.
