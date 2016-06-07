From: eric@anholt.net (Eric Anholt)
Date: Tue, 07 Jun 2016 13:23:01 -0700
Subject: [PATCH] dmaengine: bcm2835: fix unexported function
In-Reply-To: <1465316096-6025-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465316096-6025-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <87vb1k695m.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Dooks <ben.dooks@codethink.co.uk> writes:

> The bcm2835_dma_prep_dma_memcpy() function is not exported
> outside the driver, so make it static to avoid the following
> warning:
>
> drivers/dma/bcm2835-dma.c:616:32: warning: symbol 'bcm2835_dma_prep_dma_memcpy' was not declared. Should it be static?
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160607/3d61cfcc/attachment.sig>
