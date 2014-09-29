From: Valdis.Kletnieks@vt.edu (Valdis.Kletnieks at vt.edu)
Date: Mon, 29 Sep 2014 15:21:58 -0400
Subject: [PATCH resend] arm:extend the reserved memory for initrd to be
 page aligned
In-Reply-To: Your message of "Fri, 26 Sep 2014 10:40:54 +0800."
 <35FD53F367049845BC99AC72306C23D103D6DB49163B@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D103D6DB49161F@CNBJMBX05.corpusers.net>
 <20140919095959.GA2295@e104818-lin.cambridge.arm.com>
 <20140925143142.GF5182@n2100.arm.linux.org.uk>
 <20140925154403.GL10390@e104818-lin.cambridge.arm.com>
 <35FD53F367049845BC99AC72306C23D103D6DB49163B@CNBJMBX05.corpusers.net>
Message-ID: <15815.1412018518@turing-police.cc.vt.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Sep 2014 10:40:54 +0800, "Wang, Yalin" said:

> I am really confused,
> I read this web:
> http://www.arm.linux.org.uk/developer/patches/info.php
> it said use diff -urN to generate patch like this:
>
> diff -Nru linux.orig/lib/string.c linux/lib/string.c
>
> but I see other developers use git format-patch to generate patch and
> submit to the patch system.
> Git format-patch format can also be accepted by the patch system correctly ?
> If yes, I think this web should update,
> Use git format-patch to generate patch is more convenient than use diff -urN

'diff -urN' has the advantage that it will work against a tree extracted
from a release tarball, and doesn't have a requirement that you have git
installed.  Having said that, somebody who has access to the website probably
should update it to mention that both methods are acceptable....

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 848 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140929/67b69ff5/attachment.sig>
