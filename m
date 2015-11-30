From: broonie@kernel.org (Mark Brown)
Date: Mon, 30 Nov 2015 16:41:39 +0000
Subject: [PATCH 1/2] regulator: Add coupled regulator
In-Reply-To: <1448897346-17780-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1448897346-17780-1-git-send-email-maxime.ripard@free-electrons.com>
 <1448897346-17780-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20151130164139.GD1929@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2015 at 04:29:05PM +0100, Maxime Ripard wrote:

> +static struct of_device_id coupled_regulator_of_match[] = {
> +	{ .compatible = "coupled-voltage-regulator" },
> +	{ /* Sentinel */ },
> +};

This defines a device tree binding but does not document it -
doucmentation is mandatory for all new device tree bindings.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151130/dccefb60/attachment-0001.sig>
