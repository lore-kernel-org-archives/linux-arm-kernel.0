From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 May 2017 09:24:58 +0200
Subject: [PATCH 5/6] ARM: sun8i: a83t: Add device node for SPDIF
 transmitter
In-Reply-To: <20170522062552.19026-6-wens@csie.org>
References: <20170522062552.19026-1-wens@csie.org>
 <20170522062552.19026-6-wens@csie.org>
Message-ID: <20170522072458.v4d3bm3y6pacljp2@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 02:25:51PM +0800, Chen-Yu Tsai wrote:
> The A83T SoC has an SPDIF transmitter block. According to the vendor
> BSP kernel, it is compatible with the one found on the H3 SoC.
> 
> Add a device node and pinmux setting for it.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170522/16295b63/attachment-0001.sig>
