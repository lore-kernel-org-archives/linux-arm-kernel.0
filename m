From: broonie@kernel.org (Mark Brown)
Date: Mon, 8 Oct 2018 22:20:21 +0100
Subject: next-20181008 build: 2 failures 22 warnings (next-20181008)
In-Reply-To: <E1g9cV0-0008Sg-4U@optimist>
References: <E1g9cV0-0008Sg-4U@optimist>
Message-ID: <20181008212021.GB4440@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2018 at 09:51:30PM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build an arm allmodconfig caused by:

> 	arm-allmodconfig
> ../drivers/pci/pcie/aer_inject.c:444:6: error: 'struct pt_regs' has no member named 'ip'

introduced in e3fbcc7c4b130(PCI/AER: Covertly inject errors with ftrace
hooks).  This field is not present on arm.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181008/1ecd49d3/attachment-0001.sig>
