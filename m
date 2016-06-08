From: broonie@kernel.org (Mark Brown)
Date: Wed, 8 Jun 2016 11:55:38 +0100
Subject: [PATCH] spi: rockchip: Signal unfinished DMA transfers
In-Reply-To: <1465371171-20810-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1465371171-20810-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20160608105538.GF7510@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 09:32:51AM +0200, Tomeu Vizoso wrote:

> +		/* successful DMA prepare means the transfer is in progress */
> +		ret = ret ? ret : 1;

Please write normal if statements so people can read the code more
easily.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160608/ce7a508a/attachment.sig>
