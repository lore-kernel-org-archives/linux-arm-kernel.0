From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 17 Nov 2016 21:27:49 +0100
Subject: [PATCH v4 2/2] ARM: dts: sun6i: hummingbird-a31: Enable display
 output through VGA bridge
In-Reply-To: <20161116154232.872-3-wens@csie.org>
References: <20161116154232.872-1-wens@csie.org>
 <20161116154232.872-3-wens@csie.org>
Message-ID: <20161117202749.kotctovy5cquaxfp@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 11:42:32PM +0800, Chen-Yu Tsai wrote:
> The Hummingbird A31 board has a VGA DAC which converts RGB output
> from the LCD interface to VGA analog signals.
> 
> Add nodes for the VGA DAC, its power supply, and enable this part
> of the display pipeline.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161117/14fb64a4/attachment.sig>
