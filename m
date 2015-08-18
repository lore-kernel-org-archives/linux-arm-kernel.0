From: broonie@kernel.org (Mark Brown)
Date: Tue, 18 Aug 2015 09:07:49 -0700
Subject: [PATCH] spi: mediatek: fix spi incorrect endian usage and remove
 redundant clock
In-Reply-To: <CAOiHx=nBOtm3c7QQpA-SSxXzJGjUEJQBtR9CynoeqsXRoz4fRg@mail.gmail.com>
References: <1439895231-17778-1-git-send-email-leilk.liu@mediatek.com>
 <CAOiHx=nBOtm3c7QQpA-SSxXzJGjUEJQBtR9CynoeqsXRoz4fRg@mail.gmail.com>
Message-ID: <20150818160749.GJ10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 18, 2015 at 02:19:54PM +0200, Jonas Gorski wrote:

> The usual philosophy is to have one change per patch, so this might be
> better as three patches. But this is Mark's call. Since the driver
> isn't yet in Linus' tree, it might be a-ok to mix style improvements
> and actual fixes, but as soon as it landed in Linus' tree you need to
> keep them separate, so fixes can be easily backported.

This isn't just about making the fixes easy to backport, it's also about
making the patch reviewable and understandable.  When many changes are
included in one patch it makes it harder to tell what any one part of
the patch is intended to do.  As Jonas has identified several bugs
you'll need to resend anyway, please split the series up.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150818/27b60471/attachment-0001.sig>
