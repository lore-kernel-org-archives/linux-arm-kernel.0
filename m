From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 27 May 2011 17:11:58 +0800
Subject: [PATCH 2/3] ARM: mxs: add gpio-mxs platform devices
In-Reply-To: <201105201623.40990.arnd@arndb.de>
References: <1305885446-27404-1-git-send-email-shawn.guo@linaro.org>
	<201105201223.00427.arnd@arndb.de>
	<20110520140316.GA27551@S2100-06.ap.freescale.net>
	<201105201623.40990.arnd@arndb.de>
Message-ID: <20110527091158.GD30146@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 20, 2011 at 04:23:40PM +0200, Arnd Bergmann wrote:
[...]
> No, this would put all gpio devices below the top-level /sys/devices/platform
> directory, where they certainly don't belong. Please find a proper
> place and put them there.
> 
To make it clear, which one is the best to have all gpio devices below?

 * /sys/devices/platform/gpio-mxs
 * /sys/devices/platform/mxs
 * /sys/devices/platform/mxs/gpio

-- 
Regards,
Shawn
