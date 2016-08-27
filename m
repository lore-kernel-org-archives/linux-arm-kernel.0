From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 27 Aug 2016 13:59:25 +0200
Subject: [PATCH] ARM: dts: sun9i: Add missing #interrupt-cells to R_PIO
 pinctrl device node
In-Reply-To: <20160827075950.26524-1-wens@csie.org>
References: <20160827075950.26524-1-wens@csie.org>
Message-ID: <20160827115925.GP3165@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 27, 2016 at 03:59:50PM +0800, Chen-Yu Tsai wrote:
> The R_PIO device node is missing #interrupt-cells, which causes
> interrupt parsing to fail to match it as a valid interrupt controller.
> 
> Add #interrupt-cells to it. Also remove the unnecesary #address-cells
> and #size-cells.
> 
> Fixes: 1ac56a6da9e1 ("ARM: dts: sun9i: Add A80 R_PIO pin controller device
> 		      node")
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
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160827/bde89170/attachment.sig>
