From: broonie@kernel.org (Mark Brown)
Date: Thu, 1 Sep 2016 21:00:57 +0100
Subject: [PATCH] ASoC: rockchip: use SPI dependency for rt5514
In-Reply-To: <20160826155120.1162512-1-arnd@arndb.de>
References: <20160826155120.1162512-1-arnd@arndb.de>
Message-ID: <20160901200057.GO5967@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2016 at 05:50:55PM +0200, Arnd Bergmann wrote:

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: c6eac8a36a84 ("ASoC: rockchip: Add machine driver for RK3399 GRU Boards")

The Fixes is usually sorted before everything else, looks a bit odd like
that especially as more signoffs get added.  It's also a bit redundant
to use both () and "" not that it makes a huge difference.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160901/5571be04/attachment.sig>
