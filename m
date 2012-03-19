From: vapier@gentoo.org (Mike Frysinger)
Date: Sun, 18 Mar 2012 20:42:22 -0400
Subject: [PATCH] Kbuild: centralize MKIMAGE and cmd_uimage definitions
In-Reply-To: <1331931835-12346-1-git-send-email-swarren@wwwdotorg.org>
References: <1331931835-12346-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201203182042.27555.vapier@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 March 2012 17:03:55 Stephen Warren wrote:
> All ARCHs have the same definition of MKIMAGE. Move it to Makefile.lib
> to avoid duplication.
> 
> All ARCHs have similar definitions of cmd_uimage. Place a sufficiently
> parameterized version in Makefile.lib to avoid duplication.

seems to build for Blackfin systems.
Tested-by: Mike Frysinger <vapier@gentoo.org>
-mike
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120318/491a1de7/attachment.sig>
