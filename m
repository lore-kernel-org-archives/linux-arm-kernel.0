From: broonie@kernel.org (Mark Brown)
Date: Fri, 16 Oct 2015 15:35:13 +0100
Subject: [PATCH] spi: bcm2835: change initialization order and switch to
 platform_get_irq
In-Reply-To: <1444903752-9180-1-git-send-email-kernel@martin.sperl.org>
References: <1444903752-9180-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <20151016143513.GN14956@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 10:09:11AM +0000, kernel at martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> Change the initialization order of the HW so that the interrupt
> is only requested after the HW is initialized
> 
> Also the use of irq_of_parse_and_map is replaced by platform_get_irq.

Thanks for doing this, but as I keep saying please send one change per
patch since it makes review and applying much easier.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151016/76097aa2/attachment.sig>
