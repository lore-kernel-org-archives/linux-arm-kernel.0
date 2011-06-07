From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 7 Jun 2011 12:45:36 -0300
Subject: [PATCH 1/5] DRM: add i.MX IPUv3 base driver
In-Reply-To: <1307443550-25549-2-git-send-email-s.hauer@pengutronix.de>
References: <1307443550-25549-1-git-send-email-s.hauer@pengutronix.de>
	<1307443550-25549-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <BANLkTinLWq+ONvkKgRm4xucRgA3xTemn1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Tue, Jun 7, 2011 at 7:45 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
...
> +static int __init imx_ipu_init(void)
> +{
> + ? ? ? int32_t ret;
> +
> + ? ? ? ret = platform_driver_register(&imx_ipu_driver);
> + ? ? ? return 0;

Did you intend to return ret here instead?

Regards,

Fabio Estevam
