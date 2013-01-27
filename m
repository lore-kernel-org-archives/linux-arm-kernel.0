From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 27 Jan 2013 10:51:46 +0800
Subject: [PATCH 11/19] regmap: regmap: avoid spurious warning in
 regmap_read_debugfs
In-Reply-To: <201301261145.36158.arnd@arndb.de>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <20130126100326.GK30594@opensource.wolfsonmicro.com>
 <20130126100744.GD23505@n2100.arm.linux.org.uk>
 <201301261145.36158.arnd@arndb.de>
Message-ID: <20130127025143.GA4650@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 26, 2013 at 11:45:35AM +0000, Arnd Bergmann wrote:

> Gcc warns about the case where regmap_read_debugfs tries to walk an
> empty map->debugfs_off_cache list, which would results in uninitialized
> variable getting returned, if we hadn't checked the same condition
> just before that.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130127/52b0ef7a/attachment.sig>
