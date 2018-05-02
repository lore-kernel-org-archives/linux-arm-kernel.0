From: jhogan@kernel.org (James Hogan)
Date: Wed, 2 May 2018 21:11:25 +0100
Subject: [PATCH 07/13] arch: remove the ARCH_PHYS_ADDR_T_64BIT config
 symbol
In-Reply-To: <20180425051539.1989-8-hch@lst.de>
References: <20180425051539.1989-1-hch@lst.de>
 <20180425051539.1989-8-hch@lst.de>
Message-ID: <20180502201123.GA20766@jamesdev>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2018 at 07:15:33AM +0200, Christoph Hellwig wrote:
> Instead select the PHYS_ADDR_T_64BIT for 32-bit architectures that need a
> 64-bit phys_addr_t type directly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

>  arch/mips/Kconfig                      | 15 ++++++---------

For MIPS:
Acked-by: James Hogan <jhogan@kernel.org>

Cheers
James
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180502/aef67c72/attachment.sig>
