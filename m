From: broonie@kernel.org (Mark Brown)
Date: Tue, 15 Aug 2017 12:16:12 +0100
Subject: next-20170815 build: 2 failures 4 warnings (next-20170815)
In-Reply-To: <E1dhZPk-0002d9-9k@optimist>
References: <E1dhZPk-0002d9-9k@optimist>
Message-ID: <20170815111612.esq73hxowbw2mehj@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 15, 2017 at 11:49:36AM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build on arm64 due to:

> 	arm64-allmodconfig
> 	arm64-defconfig
> ../drivers/acpi/spcr.c:168:1: error: expected expression before '<<' token
> ../drivers/acpi/spcr.c:198:1: error: expected expression before '>>' token

caused by f69ba1326ac33b (Merge branch 'acpi-spcr' into linux-next)
which has an unresolved conflict in it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170815/2be35cf6/attachment.sig>
