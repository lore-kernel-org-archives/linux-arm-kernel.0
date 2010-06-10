From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 10 Jun 2010 10:27:17 +0200
Subject: [PATCH 2/5] [ARM] Remove unused INITRD_PHYS from
	arch/arm/boot/compressed
In-Reply-To: <1275550613-9553-3-git-send-email-eric.miao@canonical.com>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<1275550613-9553-3-git-send-email-eric.miao@canonical.com>
Message-ID: <20100610082716.GA3422@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Jun 03, 2010 at 03:36:50PM +0800, Eric Miao wrote:
> From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> Original patch from Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Eric Miao <eric.miao@canonical.com>
The patch is OK, but the commit log of my patch was (IMHO) better.
Something like:

Only arch/arm/boot/bootp/init.S uses initrd_phys, so there is no need to
pass it in arch/arm/boot/compressed.

And I would prefer not to have this "Original patch from ..." in the
commit log.  Do you use it because the patch system doesn't offer to
specify the author of a commit?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
