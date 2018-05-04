From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 4 May 2018 17:06:35 +0200
Subject: [PATCH 3/7] pinctrl: sunxi: add support for H6 R_PIO pin
 controller
In-Reply-To: <20180503183847.11046-4-icenowy@aosc.io>
References: <20180503183847.11046-1-icenowy@aosc.io>
 <20180503183847.11046-4-icenowy@aosc.io>
Message-ID: <20180504150635.cmtypedk55oxyg2n@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2018 at 02:38:43AM +0800, Icenowy Zheng wrote:
> Allwinner H6 SoC has a R_PIO pin controller like other Allwinner SoCs,
> which controls the PL and PM pin banks.
> 
> Add support for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180504/714eefbf/attachment.sig>
