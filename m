From: broonie@kernel.org (Mark Brown)
Date: Mon, 29 Jun 2015 18:02:45 +0100
Subject: next-20150629 build: 1 failures 74 warnings (next-20150629)
In-Reply-To: <E1Z9WQC-000356-Bd@optimist>
References: <E1Z9WQC-000356-Bd@optimist>
Message-ID: <20150629170245.GI11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 29, 2015 at 11:36:17AM +0100, Build bot for Mark Brown wrote:

> 	arm-allmodconfig
> ../arch/arm/mach-socfpga/pm.c:59:2: error: implicit declaration of function 'dev_get_gen_pool' [-Werror=implicit-function-declaration]

For a short while now -next has been failing to build an ARM
allmodconfig due to a collision between "genalloc: rename
dev_get_gen_pool() to gen_pool_get()" in the akpm tree and "ARM:
socfpga: support suspend to ram" which as been added via the arm-soc
tree and introduces a new use.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150629/50c9c0e6/attachment.sig>
