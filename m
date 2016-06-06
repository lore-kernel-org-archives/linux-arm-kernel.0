From: broonie@kernel.org (Mark Brown)
Date: Mon, 6 Jun 2016 18:36:51 +0100
Subject: [PATCH 13/22] spi: clps711x: Driver refactor
In-Reply-To: <1465024214-22120-14-git-send-email-shc_work@mail.ru>
References: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
 <1465024214-22120-14-git-send-email-shc_work@mail.ru>
Message-ID: <20160606173651.GD7510@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 04, 2016 at 10:10:05AM +0300, Alexander Shiyan wrote:

> +static const struct of_device_id clps711x_spi_dt_ids[] = {
> +	{ .compatible = "cirrus,ep7209-spi", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, clps711x_spi_dt_ids);

This adds a new binding but no binding document - all new bindings need
binding documents.  Other than that it looks fine.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160606/4e8563f8/attachment.sig>
