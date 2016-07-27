From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Jul 2016 09:27:55 +0200
Subject: [PATCH 6/9] clk: sunxi-ng: nkm: Add mux to support multiple
 parents
In-Reply-To: <1469516671-19377-7-git-send-email-wens@csie.org>
References: <1469516671-19377-1-git-send-email-wens@csie.org>
 <1469516671-19377-7-git-send-email-wens@csie.org>
Message-ID: <20160727072755.GF6560@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2016 at 03:04:28PM +0800, Chen-Yu Tsai wrote:
> The MIPI mode of the MIPI-PLL on A31 is an NKM-style PLL with 2
> selectable parents.
> 
> Add mux support to the NKM clock.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160727/147cffd2/attachment.sig>
