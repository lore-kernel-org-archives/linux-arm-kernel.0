From: broonie@kernel.org (Mark Brown)
Date: Thu, 16 Oct 2014 11:34:40 +0200
Subject: [PATCH 2/2] spi/rockchip: fix bug that cause spi transfer timed
 out in DMA duplex mode
In-Reply-To: <543F8F2A.9040904@rock-chips.com>
References: <1413372311-4203-1-git-send-email-addy.ke@rock-chips.com>
 <1413372378-4309-1-git-send-email-addy.ke@rock-chips.com>
 <20141015130547.GE27755@sirena.org.uk>
 <543F8F2A.9040904@rock-chips.com>
Message-ID: <20141016093440.GC2200@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 16, 2014 at 05:26:02PM +0800, addy ke wrote:

> The following changes is nessarry:(if tx complete, spi must be disabled too)
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index 153269b..87bc16f 100644

Please send this using the normal submission process.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141016/c1bed7ac/attachment-0001.sig>
