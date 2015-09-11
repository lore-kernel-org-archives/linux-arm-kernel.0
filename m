From: broonie@kernel.org (Mark Brown)
Date: Fri, 11 Sep 2015 12:28:07 +0100
Subject: [PATCH v4 08/10] spi: rockchip: modify DMA max burst to 1
In-Reply-To: <1441501986-14034-1-git-send-email-shawn.lin@rock-chips.com>
References: <1441501881-13700-1-git-send-email-shawn.lin@rock-chips.com>
 <1441501986-14034-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <20150911112807.GH12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 06, 2015 at 09:13:06AM +0800, Shawn Lin wrote:
> From: Addy Ke <addy.ke@rock-chips.com>
> 
> Generic dma controller on Rockchips' platform cannot support
> DMAFLUSHP instruction which make dma to flush the req of non-aligned
> or non-multiple of what we need. That will cause an unrecoverable
> dma bus error. The saftest way is to set dma max burst to 1.

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150911/ceedbc0c/attachment.sig>
