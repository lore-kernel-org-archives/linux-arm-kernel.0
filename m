From: rubini@unipv.it (Alessandro Rubini)
Date: Sat, 15 Sep 2012 13:33:56 +0200
Subject: [PATCH 13/24] ARM: nomadik: use __iomem pointers for MMIO
In-Reply-To: <1347658492-11608-14-git-send-email-arnd@arndb.de>
References: <1347658492-11608-14-git-send-email-arnd@arndb.de>
 <1347658492-11608-1-git-send-email-arnd@arndb.de>
Message-ID: <20120915113356.GA31284@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -	.options	= NAND_COPYBACK | NAND_CACHEPRG | NAND_NO_PADDING \
> -			| NAND_NO_READRDY,
> +	.options	= NAND_COPYBACK | NAND_CACHEPRG | NAND_NO_PADDING,

This is not clear to me, and it looks unrelated. But I admit I haven't
studied what happened to NAND_NO_READRDY lately.

If this hunk is desired and not just something else
that slipped in, then

  Acked-by: Alessandro Rubini <rubini@unipv.it>
