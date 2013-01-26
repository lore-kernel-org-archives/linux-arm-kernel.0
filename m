From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 26 Jan 2013 18:03:28 +0800
Subject: [PATCH 11/19] regmap: avoid undefined return from
 regmap_read_debugfs
In-Reply-To: <20130126095916.GB23505@n2100.arm.linux.org.uk>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359123276-15833-12-git-send-email-arnd@arndb.de>
 <20130126044219.GA10580@opensource.wolfsonmicro.com>
 <201301260917.28028.arnd@arndb.de>
 <20130126094855.GI30594@opensource.wolfsonmicro.com>
 <20130126095916.GB23505@n2100.arm.linux.org.uk>
Message-ID: <20130126100326.GK30594@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 26, 2013 at 09:59:16AM +0000, Russell King - ARM Linux wrote:

> Why not code the function in a way that avoids the problem altogether?

That'd do the trick too; feel free to submit a patch...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130126/d93dd193/attachment.sig>
