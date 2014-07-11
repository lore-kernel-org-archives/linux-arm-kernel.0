From: broonie@kernel.org (Mark Brown)
Date: Fri, 11 Jul 2014 14:48:48 +0100
Subject: [PATCH] ASoC: rockchips: fix build error
In-Reply-To: <1405084028-1209898-1-git-send-email-arnd@arndb.de>
References: <1405084028-1209898-1-git-send-email-arnd@arndb.de>
Message-ID: <20140711134848.GX30458@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 03:07:08PM +0200, Arnd Bergmann wrote:
> The newly added rockchip_i2s driver is lacking an include of
> linux/module.h, causing a build error in some cases:

A fix for this has already been applied.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140711/57585e75/attachment.sig>
