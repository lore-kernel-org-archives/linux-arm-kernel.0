From: davem@davemloft.net (David Miller)
Date: Wed, 06 Feb 2013 15:04:31 -0500 (EST)
Subject: [PATCH v2 1/2 net-next] net: fec: fix miss init spinlock
In-Reply-To: <1360045577-6266-1-git-send-email-Frank.Li@freescale.com>
References: <1360045577-6266-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20130206.150431.408313770070806281.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>
Date: Tue, 5 Feb 2013 14:26:16 +0800

> Change from v1 to v2
>  - avoid reinit hwreg_lock twice

I already applied your v1 patch, so you have to revert that spin_lock_init()
call in this change.

Please do that and respin this patch series.
