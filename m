From: broonie@debian.org (Mark Brown)
Date: Wed, 1 Oct 2014 19:20:03 +0100
Subject: [PATCH 1/2] mtd: m25p80: get rid of spi_get_device_id
In-Reply-To: <1411984074-3850-1-git-send-email-zajec5@gmail.com>
References: <1411984074-3850-1-git-send-email-zajec5@gmail.com>
Message-ID: <20141001182003.GB17974@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 11:47:53AM +0200, Rafa? Mi?ecki wrote:
> This simplifies the way we use spi_nor framework and will allow us to
> drop spi_nor_match_id.

Please don't CC linux-spi on spi-nor patches that don't have SPI level
changes, it just clogs up patchwork.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141001/3303b81b/attachment.sig>
