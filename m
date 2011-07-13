From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 13 Jul 2011 11:08:19 +0200
Subject: [PATCH V2 04/10] ASoc: mxs: add asoc configuration files
In-Reply-To: <1310483085-31442-5-git-send-email-b29396@freescale.com>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-5-git-send-email-b29396@freescale.com>
Message-ID: <20110713090819.GB1928@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +if SND_MXS_SOC
> +
> +config SND_SOC_MXS_SGTL5000
> +	tristate "SoC Audio support for i.MX boards with sgtl5000"

depends on I2C

> +	select SND_SOC_SGTL5000
> +	help
> +	  Say Y if you want to add support for SoC audio on an MXS board with
> +	  a sgtl5000 codec.
> +
> +endif	# SND_MXS_SOC

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110713/540e5edb/attachment-0001.sig>
