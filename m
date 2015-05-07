From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 7 May 2015 10:58:15 +0200
Subject: [PATCH] ARM: imx: using unsigned variable for do_div
In-Reply-To: <1431015411-8432-1-git-send-email-b20788@freescale.com>
References: <1431015411-8432-1-git-send-email-b20788@freescale.com>
Message-ID: <20150507085815.GH12306@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 12:16:51AM +0800, Anson Huang wrote:
> The definition of do_div uses unsigned long long
> variable as its first parameter, better to pass
> a u64 variable as first parameter when calling
> do_div function.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
