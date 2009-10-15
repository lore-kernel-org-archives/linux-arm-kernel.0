From: sascha-ml-devel-openrd-google@silbe.org (Sascha Silbe)
Date: Thu, 15 Oct 2009 14:10:22 +0200
Subject: arm / kirkwood (openrd): cpu_idle
In-Reply-To: <200910151352.41991.dk-arm-linux@gmx.de>
References: <200910151352.41991.dk-arm-linux@gmx.de>
Message-ID: <20091015121022.GC26774@twin.sascha.silbe.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2009 at 01:52:41PM +0200, Dieter Kiermaier wrote:

> But it looks like that in rc4 something has changed so the patch 
> didn't apply without errors.
It was quite easy to resolve (even though I don't understand any of the 
touched code), see [1] for a rebased patch.
I'm wondering why it wasn't merged upstream yet, though.


[1] 
http://sascha.silbe.org/openrd/0001-apply-cpu_idle-IRQ-fix-from-http-patchwork.kernel.patch

CU Sascha

-- 
http://sascha.silbe.org/
http://www.infra-silbe.de/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 489 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091015/233666d6/attachment.sig>
