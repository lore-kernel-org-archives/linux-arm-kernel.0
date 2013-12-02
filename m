From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 Dec 2013 12:21:13 +0000
Subject: [PATCH v2 1/3] mfd: tps6586x: add version detection
In-Reply-To: <2d5282f031a16d2ff227694daaabc977440fbd2e.1385913228.git.stefan@agner.ch>
References: <cover.1385913227.git.stefan@agner.ch>
 <2d5282f031a16d2ff227694daaabc977440fbd2e.1385913228.git.stefan@agner.ch>
Message-ID: <20131202122113.GY27568@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 01, 2013 at 04:59:13PM +0100, Stefan Agner wrote:

> +int tps6586x_get_version(struct device *dev)
> +{
> +	struct tps6586x *tps6586x = dev_get_drvdata(dev);
> +
> +	return tps6586x->version;
> +}
> +EXPORT_SYMBOL_GPL(tps6586x_get_version);

May as well make this a static inline in the header.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131202/955b912f/attachment.sig>
