From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 28 Aug 2018 16:55:17 +0200
Subject: [PATCH v8 7/8] ARM: dts: sun8i-a33: Add Video Engine and
 reserved memory nodes
In-Reply-To: <20180828073424.30247-8-paul.kocialkowski@bootlin.com>
References: <20180828073424.30247-1-paul.kocialkowski@bootlin.com>
 <20180828073424.30247-8-paul.kocialkowski@bootlin.com>
Message-ID: <20180828145517.p2ijrsfu576xwf7t@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 09:34:23AM +0200, Paul Kocialkowski wrote:
> This adds nodes for the Video Engine and the associated reserved memory
> for the A33. Up to 96 MiB of memory are dedicated to the CMA pool.
> 
> The VPU can only map the first 256 MiB of DRAM, so the reserved memory
> pool has to be located in that area. Following Allwinner's decision in
> downstream software, the last 96 MiB of the first 256 MiB of RAM are
> reserved for this purpose.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180828/5e65d03f/attachment.sig>
