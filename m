From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 3 Nov 2009 20:20:25 +0100
Subject: [PATCH] [RTC] Add Freescale MC13783 RTC driver
In-Reply-To: <1256373342-5294-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1256330323-13300-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1256373342-5294-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20091103192025.GA20260@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sat, Oct 24, 2009 at 10:35:42AM +0200, Uwe Kleine-K?nig wrote:
> This driver provides support for the RTC part integrated into the
> Freescale MC13783 PMIC and bases on patch created earlier by Sascha
> Hauer.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-k?nig@pengutronix.de>
> Cc: Valentin Longchamp <valentin.longchamp@epfl.ch>
> Cc: Paul Gortmaker <p_gortmaker@yahoo.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: rtc-linux at googlegroups.com
> ---
> Hello,
> 
> this patch depends on
> 
> 	mfd/mc13783: near complete rewrite
> 
> sent earlier on lkml[1].  Compared to the earlier version of rtc support
> on mc13783 as sent by Sascha, this driver got reset detection and
> therefore depends on the patch above.
> 
> A tree runnable on Phytec's PCM038 is available in my git tree
> 
> 	git://git.pengutronix.de/git/ukl/linux-2.6.git mc13783
> 
> .  (Maybe I will rewrite these commits, so please expect it might change
> in a non-fast-forward manner.)
This happend now.  Based on feed-back for the mc13783-core driver I had
to modify the rtc-driver to.  Only the signature of the irq handler
function changed.

I don't consider that change worth to repost, so if you're interested
please check out my branch.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
