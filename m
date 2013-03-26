From: davem@davemloft.net (David Miller)
Date: Tue, 26 Mar 2013 12:19:40 -0400 (EDT)
Subject: [PATCH 1/1] enet: fec: fix fail resume from suspend state
In-Reply-To: <1364264097-26157-1-git-send-email-Frank.Li@freescale.com>
References: <1364264097-26157-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20130326.121940.937673963522554506.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>
Date: Tue, 26 Mar 2013 10:14:57 +0800

> Without this patch
> 1. boot with nfs (no_console_suspend)
> 2. echo mem >/sys/power/state
> 3. wakeup by wakesource
> 4. print "eth0: tx queue full"
> 
> This fix above problem by reinit bd queue at restart function
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>

Patch applies neither to 'net' nor 'net-next'.

Please respin this cleanly against current sources.
