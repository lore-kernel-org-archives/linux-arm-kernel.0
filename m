From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 13 Oct 2017 09:28:03 +0200
Subject: [PATCH 0/9] clk: sunxi-ng: Use sigma-delta modulation for audio
 PLL
In-Reply-To: <20171012083705.24409-1-wens@csie.org>
References: <20171012083705.24409-1-wens@csie.org>
Message-ID: <20171013072803.y6nqwpgry2eqxgop@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 12, 2017 at 08:36:56AM +0000, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This series adds support for fractional-N synthesis using sigma-delta
> modulation in the audio PLL to get the exact required clock rate.
> This fixes the speed and pitch change when audio is played back on
> sunxi platforms, due to the slightly inaccurate audio clock.
> 
> I've done this for all platforms I can test at the moment. A83T is left
> out for now as the the clock unit's design is slightly different. I
> was unable to work on the A33, as my board is very unstable, plus A33
> audio playback seems to be broken at the moment. There might be some
> issue with the DAPM routes.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171013/18a35be7/attachment.sig>
