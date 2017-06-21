From: broonie@kernel.org (Mark Brown)
Date: Wed, 21 Jun 2017 11:04:40 +0100
Subject: next-20170621 build: 1 failures 7 warnings (next-20170621)
In-Reply-To: <E1dNcMp-0005RN-1w@optimist>
References: <E1dNcMp-0005RN-1w@optimist>
Message-ID: <20170621100440.vcaxagg4yjca2cv4@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 10:56:07AM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build an arm allmodconfig due to:

> 	arm-allmodconfig
> ../drivers/pci/host/pcie-mediatek.c:485:8: error: implicit declaration of function 'pci_register_host_bridge' [-Werror=implicit-function-declaration]

caused by eaf3023b0498a (PCI: mediatek: Add MediaTek PCIe host
controller support).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170621/165315aa/attachment.sig>
