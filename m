From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 14 Nov 2014 21:10:36 +0100
Subject: [PATCH] MAINTAINERS: add pattern for respective device tree
 files to Armada entry
In-Reply-To: <1415994009-3548-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1415994009-3548-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20141114201036.GH2001@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 08:40:09PM +0100, Uwe Kleine-K?nig wrote:
> This makes it more likely that changes to these files are addressed to the
> right maintainers.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 60b1163dba28..282e5427209c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1136,6 +1136,7 @@ M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	arch/arm/mach-mvebu/
> +F:	arch/arm/boot/dts/armada-*

Hi Uwe

Maybe also add kirkwood-* and dove-*

      Andrew
