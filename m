From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 9 Dec 2010 15:34:45 +0100
Subject: [PATCH 2/9] ARM i.MX51: rename IPU irqs
In-Reply-To: <1291902441-24712-3-git-send-email-s.hauer@pengutronix.de>
References: <1291902441-24712-1-git-send-email-s.hauer@pengutronix.de>
	<1291902441-24712-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20101209143445.GX17441@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 09, 2010 at 02:47:14PM +0100, Sascha Hauer wrote:
> -#define MX51_MXC_INT_IPU_ERR		10
> -#define MX51_MXC_INT_IPU_SYN		11
> +#define MX51_INT_IPU_ERR		10
> +#define MX51_INT_IPU_SYN		11
This one is easy.  Acked-by: me.  Maybe it's worth to do

	git ls-files | xargs perl -p -i -e 's/\bMX51_MXC_INT_/MX51_INT_/

and then fix up the layout damage.

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
