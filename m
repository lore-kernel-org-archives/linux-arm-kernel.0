From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Feb 2017 18:56:50 +0100
Subject: [PATCH] clk: sunxi-ng: sun6i: Fix enable bit offset for hdmi-ddc
 module clock
In-Reply-To: <20170214022332.13326-1-wens@csie.org>
References: <20170214022332.13326-1-wens@csie.org>
Message-ID: <20170216175650.kkwbmwa4yyk33ozp@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2017 at 10:23:32AM +0800, Chen-Yu Tsai wrote:
> The enable bit offset for the hdmi-ddc module clock is wrong. It is
> pointing to the main hdmi module clock enable bit.
> 
> Reported-by: Bob Ham <rah@settrans.net>
> Fixes: c6e6c96d8fa6 ("clk: sunxi-ng: Add A31/A31s clocks")
> Cc: stable at vger.kernel.org # 4.9.x-
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Queued as a fix for 4.11, thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170216/0dd51a64/attachment.sig>
