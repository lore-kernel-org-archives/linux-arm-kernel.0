From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 17 Jul 2012 19:57:49 +0100
Subject: Boot breaks in -next from LEGACY to LINEAR conversion
Message-ID: <20120717185749.GJ4477@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-next fails to boot for me today on my s3c64xx based systems.  Walking
back to the last time I tried and bisecting likely branches I find that
commit 910139 (irqdomain: Replace LEGACY mapping with LINEAR) is the one
that introduces the build break.  Unfortunately the boot fails before I
get a console which makes diagnosis somewhat more tricky than would be
ideal.  Any ideas?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120717/b89437d7/attachment.sig>
