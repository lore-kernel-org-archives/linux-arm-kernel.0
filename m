From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Jul 2016 08:43:44 +0200
Subject: [PATCH 3/9] clk: sunxi-ng: mux: Increase fixed pre-divider div
 size
In-Reply-To: <1469516671-19377-4-git-send-email-wens@csie.org>
References: <1469516671-19377-1-git-send-email-wens@csie.org>
 <1469516671-19377-4-git-send-email-wens@csie.org>
Message-ID: <20160727064344.GB6560@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2016 at 03:04:25PM +0800, Chen-Yu Tsai wrote:
> Some clocks have a predivider value that is larger than what u8 can
> store. One such example is the OUT clk found on A20/A31, which has
> a /750 pre-divider on one of the osc24M parents.
> 
> Increase the size of the div field to u16.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160727/97cfdea4/attachment.sig>
