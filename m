From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 16 Jun 2012 00:06:37 +0800
Subject: [PATCH v3 2/2] serial: mxs-auart: Allow device tree probing
In-Reply-To: <1339774557-23588-2-git-send-email-fabio.estevam@freescale.com>
References: <1339774557-23588-1-git-send-email-fabio.estevam@freescale.com>
 <1339774557-23588-2-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120615160635.GP31565@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 15, 2012 at 12:35:57PM -0300, Fabio Estevam wrote:
> +static struct platform_device_id mxs_auart_devtype[] = {
> +	{
> +		.name = "mxs-auart",
> +		/* sentinel */
> +	}
> +};
> +MODULE_DEVICE_TABLE(platform, mxs_auart_devtype);
...
> +		.id_table = mxs_auart_devtype,

I do not think we need these.

-- 
Regards,
Shawn
