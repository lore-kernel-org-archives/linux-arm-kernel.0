From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Sep 2013 10:55:23 +0100
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <522697E9.1050208@freescale.com>
References: <1377828449-18912-1-git-send-email-b32955@freescale.com>
 <522697E9.1050208@freescale.com>
Message-ID: <20130904095523.GT3084@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 04, 2013 at 10:16:09AM +0800, Huang Shijie wrote:

> Since this quadspi driver depends on the mtd code, could this driver
> goes to the kernel by
> the l2-mtd tree?

Why would a SPI driver depend on MTD?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130904/a0bb2746/attachment.sig>
