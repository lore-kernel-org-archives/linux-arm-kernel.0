From: broonie@kernel.org (Mark Brown)
Date: Tue, 8 Jul 2014 16:56:05 +0200
Subject: [PATCH v3 2/2] spi: add driver for Rockchip RK3xxx SoCs
 integrated SPI
In-Reply-To: <1404784397-5157-1-git-send-email-addy.ke@rock-chips.com>
References: <1404176639-3315-1-git-send-email-addy.ke@rock-chips.com>
 <1404784397-5157-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <20140708145605.GZ30458@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 08, 2014 at 09:53:17AM +0800, Addy Ke wrote:
> In order to facilitate understanding, rockchip SPI controller IP design
> looks similar in its registers to designware. But IC implementation
> is different from designware, So we need a dedicated driver for Rockchip
> RK3XXX SoCs integrated SPI. The main differences:

This driver is already applied, please send updates as incremental
patches against the current code not as a completely new patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140708/9500a827/attachment.sig>
