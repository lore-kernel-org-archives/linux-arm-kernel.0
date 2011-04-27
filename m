From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 27 Apr 2011 10:22:20 +0200
Subject: [PATCH v4] [ARM] MX1: Add ARMadeus Systems APF9328 board support
In-Reply-To: <1303842222-28209-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1303842222-28209-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <20110427082220.GC31131@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2011 at 06:23:42PM +0000, Gwenhael Goavec-Merou wrote:
> APF9328 is an i.MXL based SOM (System On Module) that can be plugged on
> several docking/development boards. Here only basic module support
> is added (Ethernet, Serial, NOR Flash).
> 
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
> Signed-off-by: Eric Jarrige <eric.jarrige@armadeus.org>
> Signed-off-by: Nicolas Colombain <nicolas.colombain@armadeus.com>
> Signed-off-by: Julien Boibessot <julien.boibessot@armadeus.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

If someone else still has concerns some very minor comments for an
eventual v5:

 - You could add a real name to the maintainer statement in the MACHINE
   block;
 - you could substitute

	(32 * 1024 * 1024)

   by

	SZ_32M

   ;


Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
