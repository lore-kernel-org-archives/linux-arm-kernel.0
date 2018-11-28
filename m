From: eric@anholt.net (Eric Anholt)
Date: Wed, 28 Nov 2018 09:27:24 -0800
Subject: [PATCH V2 7/7] mmc: bcm2835: Properly handle
 dmaengine_prep_slave_sg
In-Reply-To: <1541967839-2847-8-git-send-email-stefan.wahren@i2se.com>
References: <1541967839-2847-1-git-send-email-stefan.wahren@i2se.com>
 <1541967839-2847-8-git-send-email-stefan.wahren@i2se.com>
Message-ID: <87y39d5czn.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> In case dmaengine_prep_slave_sg fails we need to call dma_unmap_sg.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

This series is:

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/0d646466/attachment.sig>
