From: broonie@kernel.org (Mark Brown)
Date: Wed, 15 Oct 2014 15:05:47 +0200
Subject: [PATCH 2/2] spi/rockchip: fix bug that cause spi transfer timed
 out in DMA duplex mode
In-Reply-To: <1413372378-4309-1-git-send-email-addy.ke@rock-chips.com>
References: <1413372311-4203-1-git-send-email-addy.ke@rock-chips.com>
 <1413372378-4309-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <20141015130547.GE27755@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 15, 2014 at 07:26:18PM +0800, Addy Ke wrote:
> In rx mode, dma must be prepared before spi is enabled.
> But in tx and tr mode, spi must be enabled first.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141015/732fc5ab/attachment-0001.sig>
