From: broonie@kernel.org (Mark Brown)
Date: Tue, 14 Jan 2014 14:39:45 +0000
Subject: [PATCH] spi: davinci: fix build warning when printing
 resource_size_t vars
In-Reply-To: <1389707408-24785-1-git-send-email-grygorii.strashko@ti.com>
References: <20140112110916.GR15937@n2100.arm.linux.org.uk>
 <1389707408-24785-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20140114143945.GP15567@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 03:50:08PM +0200, Grygorii Strashko wrote:
> Use %pa format specifier when printing variables of resource_size_t type
> to fix build warnings:
> drivers/spi/spi-davinci.c:966:3: warning: format '%d' expects argument of type 'int', but argument 3 has type 'resource_size_t'
> drivers/spi/spi-davinci.c:966:3: warning: format '%d' expects argument of type 'int', but argument 4 has type 'resource_size_t'

This doesn't apply against current code, it seems the same patch has
already been applied.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140114/fc47ddf5/attachment.sig>
