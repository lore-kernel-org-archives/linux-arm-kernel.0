From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 3 Sep 2018 14:42:29 +0200
Subject: [PATCH v5 0/9] ata: ahci_platform: support allwinner R40 AHCI
In-Reply-To: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
References: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
Message-ID: <20180903124229.rchurusvt4rv5ln7@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 03, 2018 at 12:01:52PM +0200, Corentin Labbe wrote:
> This patchset add support for allwinner R40 AHCI controller.
> 
> The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
> on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
> by this serie, so no regression should come with it.
> 
> Patchs 1-7 should go via the ata tree
> Patchs 8,9 should go via the sunxi tree
>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180903/e9c58cd6/attachment.sig>
