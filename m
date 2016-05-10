From: broonie@kernel.org (Mark Brown)
Date: Tue, 10 May 2016 16:08:22 +0100
Subject: [PATCH 2/4] ARM: ux500: move ab8500_regulator_plat_data into
 driver
In-Reply-To: <1462888794-2793296-3-git-send-email-arnd@arndb.de>
References: <1462888794-2793296-1-git-send-email-arnd@arndb.de>
 <1462888794-2793296-3-git-send-email-arnd@arndb.de>
Message-ID: <20160510150822.GB6261@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2016 at 03:59:48PM +0200, Arnd Bergmann wrote:
> There is only one instance of ab8500_regulator_platform_data, and it's
> safe to assume we won't ever merge another one, so it's rather pointless
> to pass it through multiple levels of platform data pointers.

I'm missing patches 1 and 4 in this series.  What's going on, especially
with regard to dependencies?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160510/50ab137a/attachment.sig>
