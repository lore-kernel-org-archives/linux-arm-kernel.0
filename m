From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 24 Apr 2018 13:54:37 +0200
Subject: [PATCH 5/7] arm64: dts: allwinner: h5: Add cpu0 label for first
 cpu
In-Reply-To: <20180424113424.13196-6-wens@csie.org>
References: <20180424113424.13196-1-wens@csie.org>
 <20180424113424.13196-6-wens@csie.org>
Message-ID: <20180424115437.bknv53qpb4sve4ew@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 07:34:22PM +0800, Chen-Yu Tsai wrote:
> At the board level, we want to be able to specify what regulator
> supplies power to the cpu domain.
> 
> Add a label to the first cpu node so we can reference it later.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180424/d40c990f/attachment.sig>
