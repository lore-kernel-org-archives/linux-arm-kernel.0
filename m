From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 26 Dec 2011 09:55:44 +0800
Subject: [PATCH] serial/imx: propagate error from of_alias_get_id instead
 of using -ENODEV
In-Reply-To: <1323894411-12294-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1323894411-12294-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20111226015543.GG8240@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 09:26:51PM +0100, Uwe Kleine-K?nig wrote:
> A quick look at of_alias_get_id shows that in the error case it returns
> -ENODEV, too, but still it's better style to propagate the value as is.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Jeremy Kerr <jeremy.kerr@canonical.com>
> Cc: Jason Liu <jason.hui@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>

I queued this for 3.3, and will send a pull-request to Greg.

-- 
Regards,
Shawn
