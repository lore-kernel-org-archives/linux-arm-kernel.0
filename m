From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 24 Apr 2018 13:54:56 +0200
Subject: [PATCH 6/7] arm64: dts: allwinner: Sort dtb entries in Makefile
In-Reply-To: <20180424113424.13196-7-wens@csie.org>
References: <20180424113424.13196-1-wens@csie.org>
 <20180424113424.13196-7-wens@csie.org>
Message-ID: <20180424115456.ekjvctlic6al6hn3@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 07:34:23PM +0800, Chen-Yu Tsai wrote:
> The dtb entries for NanoPi boards in the device tree makefile somehow
> ended up after the Orange Pi boards.
> 
> Move them so the list is properly sorted.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180424/46d8ab0b/attachment.sig>
