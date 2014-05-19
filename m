From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 19 May 2014 08:31:45 +0200
Subject: [PATCH 1/2 v4] ARM: imx: fix error handling in ipu device
 registration
In-Reply-To: <1400446261-27085-2-git-send-email-emilgoode@gmail.com>
References: <1400446261-27085-1-git-send-email-emilgoode@gmail.com>
 <1400446261-27085-2-git-send-email-emilgoode@gmail.com>
Message-ID: <20140519063145.GF16662@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 18, 2014 at 10:50:59PM +0200, Emil Goode wrote:
> If we fail to allocate struct platform_device pdev we
> dereference it after the goto label err.
> 
> This bug was found using coccinelle.
> 
> Signed-off-by: Emil Goode <emilgoode@gmail.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Shawn, is it already to late for 3.15?

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
