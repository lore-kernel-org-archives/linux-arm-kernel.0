From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 24 Aug 2018 16:59:41 +0200
Subject: [PATCH] arm64: dts: allwinner: h5: Add device node for Mali-450
 GPU
In-Reply-To: <20180824053849.7666-1-wens@csie.org>
References: <20180824053849.7666-1-wens@csie.org>
Message-ID: <20180824145941.xmz7bbrvwsj6eyoy@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2018 at 01:38:49PM +0800, Chen-Yu Tsai wrote:
> The H5 has a Mali-450 GPU with 4 Pixel Processor cores.
> 
> Interestingly, while the datasheet lists an interrupt line for the GPU's
> PMU, the hardware block itself doesn't seem to have it. Reads from the
> PMU address range all return zero, and writes are ignored.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Queued for 4.20, thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180824/cc86409f/attachment.sig>
