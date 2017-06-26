From: broonie@kernel.org (Mark Brown)
Date: Mon, 26 Jun 2017 12:56:53 +0100
Subject: next-20170626 build: 1 failures 1 warnings (next-20170626)
In-Reply-To: <E1dPPgG-0002pe-3A@optimist>
References: <E1dPPgG-0002pe-3A@optimist>
Message-ID: <20170626115653.e4xs4lk4paibuphx@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 26, 2017 at 09:47:36AM +0100, Build bot for Mark Brown wrote:

This build failure is still present in -next:

> 	arm-allmodconfig
> ../drivers/pci/host/pcie-mediatek.c:485:8: error: implicit declaration of function 'pci_register_host_bridge' [-Werror=implicit-function-declaration]

and we're at -rc7 now.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170626/d2113b70/attachment.sig>
