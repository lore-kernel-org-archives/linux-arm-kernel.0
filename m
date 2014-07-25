From: broonie@kernel.org (Mark Brown)
Date: Fri, 25 Jul 2014 18:34:00 +0100
Subject: [PATCH v2 01/16] regmap: Add regmap_get_device
In-Reply-To: <1405957142-19416-2-git-send-email-ttynkkynen@nvidia.com>
References: <1405957142-19416-1-git-send-email-ttynkkynen@nvidia.com>
 <1405957142-19416-2-git-send-email-ttynkkynen@nvidia.com>
Message-ID: <20140725173400.GZ17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 06:38:47PM +0300, Tuomas Tynkkynen wrote:
> Add a new function regmap_get_device to obtain the underlying struct
> device from a regmap.

I've applied this...

> +struct device *regmap_get_device(struct regmap *map)
> +{
> +	return map->dev;
> +}
> +

...plus a followup exporting the symbol so it can be used from modules.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140725/978e921c/attachment.sig>
