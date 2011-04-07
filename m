From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 7 Apr 2011 21:15:53 +0200
Subject: [PATCH] ARM: Allow for kernel command line concatenation
In-Reply-To: <1302182968-16708-1-git-send-email-oskar.andero@sonyericsson.com>
References: <1302182968-16708-1-git-send-email-oskar.andero@sonyericsson.com>
Message-ID: <20110407191553.GA8569@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Apr 07, 2011 at 03:29:28PM +0200, oskar.andero at sonyericsson.com wrote:
> From: Victor Boivie <victor.boivie@sonyericsson.com>
> 
> This patch allows the provided CONFIG_CMDLINE to be concatenated
> with the one provided by the boot loader. This is useful to
> merge the static values defined in CONFIG_CMDLINE with the
> boot loader's (possibly) more dynamic values, such as startup
> reasons and more.
> 
> Signed-off-by: Victor Boivie <victor.boivie@sonyericsson.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@sonyericsson.com>
> Signed-off-by: Oskar Andero <oskar.andero@sonyericsson.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
