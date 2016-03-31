From: broonie@kernel.org (Mark Brown)
Date: Thu, 31 Mar 2016 10:23:53 -0700
Subject: [PATCH 3/4] spi: use sg_alloc_table_from_buf()
In-Reply-To: <1459427384-21374-4-git-send-email-boris.brezillon@free-electrons.com>
References: <1459427384-21374-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459427384-21374-4-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160331172353.GJ2350@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 02:29:43PM +0200, Boris Brezillon wrote:
> Replace custom implementation of sg_alloc_table_from_buf() by a call to
> sg_alloc_table_from_buf().

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160331/eb047d16/attachment.sig>
