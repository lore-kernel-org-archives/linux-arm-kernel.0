From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 11 Nov 2016 21:48:20 +0100
Subject: [PATCH] clk: sunxi-ng: sun8i-h3: Set CLK_SET_RATE_PARENT for
 audio module clocks
In-Reply-To: <20161111100558.14629-2-wens@csie.org>
References: <20161111100558.14629-1-wens@csie.org>
 <20161111100558.14629-2-wens@csie.org>
Message-ID: <20161111204820.sowe7jj7i3lsltuf@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2016 at 06:05:58PM +0800, Chen-Yu Tsai wrote:
> The audio module clocks are supposed to be set according to the sample
> rate of the audio stream. The audio PLL provides the clock signal for
> thees module clocks, and only it is freely tunable.
> 
> Set CLK_SET_RATE_PARENT for the audio module clocks so their users can
> properly tune the clock rate.
> 
> Fixes: 0577e4853bfb ("clk: sunxi-ng: Add H3 clocks")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Fixed the typo and applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161111/506088d1/attachment.sig>
