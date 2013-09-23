From: broonie@kernel.org (Mark Brown)
Date: Mon, 23 Sep 2013 14:50:42 +0100
Subject: [PATCH] spi: s3c64xx: Add missing compatibles
In-Reply-To: <1379929545-27517-1-git-send-email-m.krawczuk@partner.samsung.com>
References: <1379929545-27517-1-git-send-email-m.krawczuk@partner.samsung.com>
Message-ID: <20130923135042.GH21013@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 23, 2013 at 11:45:45AM +0200, Mateusz Krawczuk wrote:
> Add compatibles for s3c6410, s5pc100 and s5pc110/s5pv210 boards.

>  static const struct of_device_id s3c64xx_spi_dt_match[] = {
> +	{ .compatible = "samsung,s3c2443-spi",
> +			.data = (void *)&s3c2443_spi_port_config,
> +	},
> +	{ .compatible = "samsung,s3c6410-spi",
> +			.data = (void *)&s3c6410_spi_port_config,
> +	},

This is missing s3c6400 and at least one other s3c24xx I think.  They
can be added later though so applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130923/40003e57/attachment.sig>
