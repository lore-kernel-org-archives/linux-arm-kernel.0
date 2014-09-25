From: broonie@kernel.org (Mark Brown)
Date: Thu, 25 Sep 2014 14:08:47 +0100
Subject: [PATCH] spi/rockchip: fix bug that cause the failture to read
 data in DMA mode
In-Reply-To: <1411628381-4029-1-git-send-email-addy.ke@rock-chips.com>
References: <1411628381-4029-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <20140925130847.GQ27755@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 02:59:41PM +0800, Addy Ke wrote:
> In my test on RK3288-pinky board, if spi is enabled, it will begin to
> read data from slave regardless of whether the DMA is ready. So we
> need prepare DMA before spi is enable.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140925/6592f5b3/attachment.sig>
