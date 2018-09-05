From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 5 Sep 2018 09:25:19 +0200
Subject: [PATCH v5 0/9] ata: ahci_platform: support allwinner R40 AHCI
In-Reply-To: <f70d43de-1305-997e-687a-d6e9978e37f5@kernel.dk>
References: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
 <f70d43de-1305-997e-687a-d6e9978e37f5@kernel.dk>
Message-ID: <20180905072519.wx4wgdklinyysad6@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 03, 2018 at 08:26:22AM -0600, Jens Axboe wrote:
> On 9/3/18 4:01 AM, Corentin Labbe wrote:
> > This patchset add support for allwinner R40 AHCI controller.
> > 
> > The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
> > on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
> > by this serie, so no regression should come with it.
> > 
> > Patchs 1-7 should go via the ata tree
> > Patchs 8,9 should go via the sunxi tree
> 
> Applied 1-7 for 4.20, thanks everyone.

Applied 8 and 9, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180905/38e83f0c/attachment.sig>
