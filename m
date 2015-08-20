From: broonie@kernel.org (Mark Brown)
Date: Thu, 20 Aug 2015 11:17:52 -0700
Subject: [PATCH v2 4/4] spi: mediatek: revise coding style
In-Reply-To: <1440062349-25513-5-git-send-email-leilk.liu@mediatek.com>
References: <1440062349-25513-1-git-send-email-leilk.liu@mediatek.com>
 <1440062349-25513-5-git-send-email-leilk.liu@mediatek.com>
Message-ID: <20150820181752.GH12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 05:19:09PM +0800, Leilk Liu wrote:
> This patch revises littery coding style according to comments.

I can't understand this commit log, sorry - what are the comments that
are being addressed?

> -	reg_val |= (((high_time - 1) & 0xff) << SPI_CFG0_SCK_HIGH_OFFSET);
> -	reg_val |= (((low_time - 1) & 0xff) << SPI_CFG0_SCK_LOW_OFFSET);
> -	reg_val |= (((holdtime - 1) & 0xff) << SPI_CFG0_CS_HOLD_OFFSET);
> -	reg_val |= (((setuptime - 1) & 0xff) << SPI_CFG0_CS_SETUP_OFFSET);
> +	reg_val |= (((sck_time - 1) & 0xff) << SPI_CFG0_SCK_HIGH_OFFSET);
> +	reg_val |= (((sck_time - 1) & 0xff) << SPI_CFG0_SCK_LOW_OFFSET);
> +	reg_val |= (((cs_time - 1) & 0xff) << SPI_CFG0_CS_HOLD_OFFSET);
> +	reg_val |= (((cs_time - 1) & 0xff) << SPI_CFG0_CS_SETUP_OFFSET);

This isn't a coding style change this is (I think) renaming a bunch of
variables for some reason.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150820/52c592c0/attachment-0001.sig>
