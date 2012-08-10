From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 10 Aug 2012 10:35:36 -0300
Subject: [PATCH v2 2/2] ARM: imx/pcm043: add oftree support
In-Reply-To: <1344591170-13638-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1344591170-13638-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1344591170-13638-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CAOMZO5D2nwDa_20S1tjnCxxhHKaMvg60X5arS2m11cayR_ZdNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/10/12, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:

> +			serial at 43f90000 {
> +				status = "okay";
> +			};
> +
> +			serial at 43f94000 {
> +				status = "okay";
> +			};

On other i.MX boards the format is:
