From: broonie@kernel.org (Mark Brown)
Date: Mon, 4 Jan 2016 22:44:05 +0000
Subject: next-20160104 build: 3 failures 15 warnings (next-20160104)
In-Reply-To: <3705737.6TGxRxdFzW@wuerfel>
References: <E1aG3zo-0000gt-2t@optimist> <20160104165025.GN16023@sirena.org.uk>
 <3705737.6TGxRxdFzW@wuerfel>
Message-ID: <20160104224405.GV16023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 11:07:41PM +0100, Arnd Bergmann wrote:
> On Monday 04 January 2016 16:50:25 Mark Brown wrote:
> > On Mon, Jan 04, 2016 at 12:12:20PM +0000, Build bot for Mark Brown wrote:

> > and various other linker errors caused by the fact that the new fman
> > driver uses PHYLIB but does not depend on or select it.

> This is the patch I submitted for the problem. I don't think that simply
> adding the 'select' would be a good idea because that would force PHYLIB
> builtin for allmodconfig.

Indeed, that was why I held off on my own patch - I wanted to go back
and try to understand why we were using a bool there.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160104/8dd9e541/attachment.sig>
