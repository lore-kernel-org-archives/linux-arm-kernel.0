From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Feb 2014 10:55:42 +0000
Subject: [PATCH 4/7] spi: pl022: attempt to get sspclk by name
In-Reply-To: <20140212103329.GC21992@e106331-lin.cambridge.arm.com>
References: <1392118632-11312-1-git-send-email-mark.rutland@arm.com>
 <1392118632-11312-5-git-send-email-mark.rutland@arm.com>
 <20140211120645.GH13533@sirena.org.uk>
 <201402111508.06267.arnd@arndb.de>
 <20140212103329.GC21992@e106331-lin.cambridge.arm.com>
Message-ID: <20140212105542.GC28112@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 10:33:29AM +0000, Mark Rutland wrote:

> For new bindings I'd really like to push people to always use named
> clocks as it makes things far more flexible, but I appreciate that here
> there are issues associated with modifying an existing binding.

> Mark, do you have specific issues that named clocks cause that I could
> look into?

None, I actively prefer naming them (though Russell's point about people
picking names poorly pre-DT does make it clear why it makes sense that
we weren't doing that).  I was just grumbling about the fact that
transitioning from unnamed to named is a bit ugly.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140212/fc22f8a3/attachment.sig>
