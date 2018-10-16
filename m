From: broonie@kernel.org (Mark Brown)
Date: Tue, 16 Oct 2018 11:27:15 +0100
Subject: [PATCH 1/3] driver core: add probe_err log helper
In-Reply-To: <20181016072244.1216-2-a.hajda@samsung.com>
References: <20181016072244.1216-1-a.hajda@samsung.com>
 <CGME20181016072249eucas1p2303b8c06a9f7c839a971fe065b0c752e@eucas1p2.samsung.com>
 <20181016072244.1216-2-a.hajda@samsung.com>
Message-ID: <20181016102715.GD7449@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2018 at 09:22:42AM +0200, Andrzej Hajda wrote:

> +int probe_err(const struct device *dev, int err, const char *fmt, ...)
> +{
> +	struct va_format vaf;
> +	va_list args;

...

> +	return err;
> +}
> +

This will need an EXPORT_SYMBOL for modules won't it?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181016/57827625/attachment-0001.sig>
