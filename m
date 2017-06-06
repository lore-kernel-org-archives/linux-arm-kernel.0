From: broonie@kernel.org (Mark Brown)
Date: Tue, 6 Jun 2017 19:57:30 +0100
Subject: [PATCH 2/3] spi: mediatek: support adjust register define
In-Reply-To: <1496387923-31674-3-git-send-email-leilk.liu@mediatek.com>
References: <1496387923-31674-1-git-send-email-leilk.liu@mediatek.com>
 <1496387923-31674-3-git-send-email-leilk.liu@mediatek.com>
Message-ID: <20170606185730.mrvgvp4hynftwahx@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 02, 2017 at 03:18:42PM +0800, Leilk Liu wrote:

> +	/* some IC design adjust register define */
> +	bool adjust_reg;

Can we have a name that's more specific to the particular quirk please?
The current name will get confusing if some future chip also needs
slightly different register settings.

Otherwise this looks good.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170606/8b667a53/attachment.sig>
