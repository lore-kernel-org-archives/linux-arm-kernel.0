From: broonie@kernel.org (Mark Brown)
Date: Mon, 18 Jul 2016 13:16:38 +0100
Subject: [PATCH V9 2/2] regulator: mt6323: Add support for MT6323 regulator
In-Reply-To: <1468843741-59637-2-git-send-email-john@phrozen.org>
References: <1468843741-59637-1-git-send-email-john@phrozen.org>
 <1468843741-59637-2-git-send-email-john@phrozen.org>
Message-ID: <20160718121638.GT30372@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 18, 2016 at 02:09:01PM +0200, John Crispin wrote:

> Changes in V9
> * drop compatible string from devicetree

Are you sure?

> +static const struct of_device_id mt6323_of_match[] = {
> +	{ .compatible = "mediatek,mt6323-regulator", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, mt6323_of_match);
> +
> +static struct platform_driver mt6323_regulator_driver = {
> +	.driver = {
> +		.name = "mt6323-regulator",
> +		.of_match_table = of_match_ptr(mt6323_of_match),
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160718/52f3a879/attachment.sig>
