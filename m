From: davem@davemloft.net (David Miller)
Date: Wed, 27 Mar 2013 14:09:45 -0400 (EDT)
Subject: [PATCH v2 1/1 net] enet: fec: fix fail resume from suspend state
In-Reply-To: <1364350323-2488-1-git-send-email-Frank.Li@freescale.com>
References: <1364350323-2488-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20130327.140945.1084520243407747388.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>
Date: Wed, 27 Mar 2013 10:12:03 +0800

> Without this patch
> 1. boot with nfs (no_console_suspend)
> 2. echo mem >/sys/power/state
> 3. wakeup by wakesource
> 4. print "eth0: tx queue full"
> 
> This fix above problem by reinit bd queue at restart function
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>

Applied.
