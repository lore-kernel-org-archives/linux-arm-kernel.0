From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 11 Dec 2013 10:48:38 +0100
Subject: [PATCH v3 01/15] mfd: menelaus: Drop __exit section annotation
In-Reply-To: <1386606085-26838-1-git-send-email-balbi@ti.com>
References: <20131209161422.GC24047@saruman.home>
 <1386606085-26838-1-git-send-email-balbi@ti.com>
Message-ID: <20131211094838.GH18888@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 09, 2013 at 10:21:11AM -0600, Felipe Balbi wrote:
> We could build that driver as a dynamically-linked module.
ups, only saw now the v3 after I commented on v2. So you addressed a
part of my comment already. Still building that driver as a module also
works without this patch, right? So this is only about hotplugging
(which usually doesn't work on i2c, so only via /sys/bus/i2c) and driver
unloading.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
