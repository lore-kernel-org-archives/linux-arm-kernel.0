From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 3 May 2017 22:28:07 +0200
Subject: [PATCH] clk: sunxi-ng: a31: Correct lcd1-ch1 clock register offset
In-Reply-To: <20170503031346.29174-1-wens@csie.org>
References: <20170503031346.29174-1-wens@csie.org>
Message-ID: <20170503202807.g33ssiyli5tw7iej@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 03, 2017 at 11:13:46AM +0800, Chen-Yu Tsai wrote:
> The register offset for the lcd1-ch1 clock was incorrectly pointing to
> the lcd0-ch1 clock. This resulted in the lcd0-ch1 clock being disabled
> when the clk core disables unused clocks. This then stops the simplefb
> HDMI output path.
> 
> Reported-by: Bob Ham <rah@settrans.net>
> Fixes: c6e6c96d8fa6 ("clk: sunxi-ng: Add A31/A31s clocks")
> Cc: stable at vger.kernel.org # 4.9.x-
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170503/f114aa5c/attachment.sig>
