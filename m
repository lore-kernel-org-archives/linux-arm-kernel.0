From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Mar 2013 11:46:56 +0800
Subject: [PATCH 1/1] enet: fec: fix fail resume from suspend state
In-Reply-To: <1364264097-26157-1-git-send-email-Frank.Li@freescale.com>
References: <1364264097-26157-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20130326034653.GA5148@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 26, 2013 at 10:14:57AM +0800, Frank Li wrote:
> Without this patch
> 1. boot with nfs (no_console_suspend)
> 2. echo mem >/sys/power/state
> 3. wakeup by wakesource
> 4. print "eth0: tx queue full"
> 
> This fix above problem by reinit bd queue at restart function
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>

On imx6q and imx28,

Tested-by: Shawn Guo <shawn.guo@linaro.org>
