From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 30 Mar 2011 10:47:16 +0200
Subject: [PATCH 1/1] ARM: imx: Add sched_clock support to i.mx platform
In-Reply-To: <1301472471-5826-1-git-send-email-Frank.Li@freescale.com>
References: <1301472471-5826-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20110330084716.GR30938@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2011 at 04:07:51PM +0800, Frank Li wrote:
> From: Xinyu Chen <xinyu.chen@freescale.com>
> 
> Add sched_clock() implement for i.mx platform to support nanosecond
> resolution time for sched clock used by scheduler.
> 
> Signed-off-by: Xinyu Chen <xinyu.chen@freescale.com>
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
Some time ago Jan Weitzel sent a series with the same intention, but
Jan's patches look a bit more robust.

See http://thread.gmane.org/gmane.linux.ports.arm.kernel/110748

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
