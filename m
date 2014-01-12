From: broonie@kernel.org (Mark Brown)
Date: Sun, 12 Jan 2014 19:29:10 +0000
Subject: [PATCH RFC 06/10] ARM: s3c64xx: pm: Add device tree based power
 domain instantiation
In-Reply-To: <1389469372-17199-7-git-send-email-tomasz.figa@gmail.com>
References: <1389469372-17199-1-git-send-email-tomasz.figa@gmail.com>
 <1389469372-17199-7-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20140112192910.GW29039@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 11, 2014 at 08:42:48PM +0100, Tomasz Figa wrote:

> This patch adds support for registering power domains of S3C64xx SoCs
> and binding devices to them using device tree.

> +#ifdef CONFIG_OF
> +static struct of_device_id s3c64xx_pd_matches[] = {
> +	{ .compatible = "samsung,s3c6400-clock", },
> +	{ .compatible = "samsung,s3c6410-clock", },
> +	{ },
>  };

Looks like a rebasing issue?  Otherwise this looks nice.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140112/d725e716/attachment.sig>
