From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Feb 2014 15:13:49 +0000
Subject: [PATCH 4/7] spi: pl022: attempt to get sspclk by name
In-Reply-To: <20140212114740.GE21992@e106331-lin.cambridge.arm.com>
References: <1392118632-11312-1-git-send-email-mark.rutland@arm.com>
 <201402111508.06267.arnd@arndb.de>
 <20140212103329.GC21992@e106331-lin.cambridge.arm.com>
 <201402121221.51233.arnd@arndb.de>
 <20140212114740.GE21992@e106331-lin.cambridge.arm.com>
Message-ID: <20140212151349.GR28112@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 11:47:40AM +0000, Mark Rutland wrote:

> I assume that for the non-dt case it's possible to name clock inputs to
> a device without the clock being associated with the name globally? If
> so we could get rid of the index usage entirely in this case.

Yes, using clk_add_alias().
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140212/59950f83/attachment.sig>
