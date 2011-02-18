From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 18 Feb 2011 22:38:46 +0100
Subject: [PATCH] mx31: add support for the bugbase 1.3 from buglabs
In-Reply-To: <1298064143-27158-1-git-send-email-GNUtoo@no-log.org>
References: <20110213211855.GC13279@pengutronix.de>
	<1298064143-27158-1-git-send-email-GNUtoo@no-log.org>
Message-ID: <20110218213846.GK22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 18, 2011 at 10:22:23PM +0100, Denis 'GNUtoo' Carikli wrote:
> Note that the hardware schematics and documentations can be obtained
>   here: http://www.bugcommunity.com/wiki/index.php/BUGbase
> 
> Signed-off-by: Denis 'GNUtoo' Carikli <GNUtoo@no-log.org>
> ---
As you didn't provide these and before someone else does the same, here
come the changes compared to v3:

 - moved "config MACH_BUG" further to the top of
   arch/arm/mach-mx3/Kconfig
 - add a copyright statement in arch/arm/mach-mx3/mach-bug.c
 - removed an empty line
 - s/\t=/ =/ in the initializer of bug_timer

I don't know why you moved config MACH_BUG, but I don't care much.

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
