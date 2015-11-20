From: broonie@kernel.org (Mark Brown)
Date: Fri, 20 Nov 2015 11:41:27 +0000
Subject: [PATCH, once again] regulator: core: avoid unused variable warning
In-Reply-To: <4219157.sstthfjICN@wuerfel>
References: <4219157.sstthfjICN@wuerfel>
Message-ID: <20151120114127.GS31303@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 12:30:24PM +0100, Arnd Bergmann wrote:

> The patch that introduced the warning is now in 4.4-rc1, and I think this
> patch is still the least ugly workaround we found.

Can we please at least have a comment explaining that this is working
around lockdep limitations?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151120/faef10f5/attachment.sig>
