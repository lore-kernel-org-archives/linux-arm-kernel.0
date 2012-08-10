From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 10 Aug 2012 10:38:02 -0300
Subject: [PATCH v2 2/2] ARM: imx/pcm043: add oftree support
In-Reply-To: <1344591170-13638-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1344591170-13638-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1344591170-13638-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CAOMZO5D=1XfV==+VvgzsJccLPiGd6xDCjVSRYxrH0VMzEtX_gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/10/12, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:

> +			serial at 43f90000 {
> +				status = "okay";
> +			};
> +
> +			serial at 43f94000 {
> +				status = "okay";

On other i.mx boards the format is:

uart1: serial at 43f90000

Should the same be done here?

This would allow to quickly recognize the port number without having
to look at the datasheet or .dtsi file.

Regards,

Fabio Estevam
