From: broonie@kernel.org (Mark Brown)
Date: Mon, 23 Mar 2015 14:25:24 -0700
Subject: next-20150323 build: 1 failures 23 warnings (next-20150323)
In-Reply-To: <E1YZyoN-00019n-50@debutante>
References: <E1YZyoN-00019n-50@debutante>
Message-ID: <20150323212524.GU14954@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 09:38:19AM +0000, Build bot for Mark Brown wrote:

In current -next the bgmac driver does not compile in an ARM
allmodconfig:

> 	arm-allmodconfig
> ../drivers/net/ethernet/broadcom/bgmac.c:20:27: fatal error: bcm47xx_nvram.h: No such file or directory

because this include file is only present on MIPS.  This looks at first
glance to have happened in the merge commit edb15d83a875a1f4 from the
MIPS tree though I think that needs a bit more investigation.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150323/93bc3c5f/attachment.sig>
