From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 25 Aug 2016 22:27:04 +0200
Subject: [PATCH v3 2/6] clk: sunxi-ng: mux: Add support for mux tables
In-Reply-To: <20160825062200.17206-3-wens@csie.org>
References: <20160825062200.17206-1-wens@csie.org>
 <20160825062200.17206-3-wens@csie.org>
Message-ID: <20160825202704.GC32598@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2016 at 02:21:56PM +0800, Chen-Yu Tsai wrote:
> Some clock muxes have holes, i.e. invalid or unconnected inputs,
> between parent mux values.
> 
> Add support for specifying a mux table to map clock parents to
> mux values.
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
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160825/73e073fc/attachment.sig>
