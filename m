From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 10 Apr 2011 20:12:38 +0200
Subject: [PATCH] fix build warnings on defconfigs
In-Reply-To: <1302375858-11253-1-git-send-email-wanlong.gao@gmail.com>
References: <1302375858-11253-1-git-send-email-wanlong.gao@gmail.com>
Message-ID: <20110410181238.GE18601@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 10, 2011 at 03:04:18AM +0800, wanlong.gao at gmail.com wrote:
> From: Wanlong Gao <wanlong.gao@gmail.com>
> 
> Change the BT_L2CAP and BT_SCO defconfigs from 'm' to 'y',
> since BT_L2CAP and BT_SCO had changed to bool configs.
Pointing out the commit that changed these two in the commit log would
be nice. Something like:

	The BT_L2CAP and BT_SCO configs are bool since

		6427451 (Bluetooth: Merge L2CAP and SCO modules into bluetooth.ko)

	. So change all defconfigs from =m to =y.

Other than that
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
