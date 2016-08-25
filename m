From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 25 Aug 2016 22:26:28 +0200
Subject: [PATCH v3 1/6] clk: sunxi-ng: nkm: Correct mux clock macro name
In-Reply-To: <20160825062200.17206-2-wens@csie.org>
References: <20160825062200.17206-1-wens@csie.org>
 <20160825062200.17206-2-wens@csie.org>
Message-ID: <20160825202628.GB32598@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2016 at 02:21:55PM +0800, Chen-Yu Tsai wrote:
> Mux support for NKM style clocks was added in commit a36583595c17 ("clk:
> sunxi-ng: nkm: Add mux to support multiple parents"). The macros for mux
> clocks was later changed in commit ad4578dc4cfa ("clk: sunxi-ng: mux:
> Rename mux macro to be consistent"), but the NKM style clock header was
> missed.
> 
> Fix the macro name so NKM with mux compiles correctly.
> 
> Fixes: a36583595c17 ("clk: sunxi-ng: nkm: Add mux to support multiple
> 		      parents")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes since v2: new patch

Squashed into the previous patch, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160825/6590732e/attachment.sig>
