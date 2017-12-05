From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 5 Dec 2017 09:27:21 +0100
Subject: [PATCH] ARM: dts: sunxi: Convert to CCU index macros for HDMI
 controller
In-Reply-To: <20171204084401.2646-1-wens@csie.org>
References: <20171204084401.2646-1-wens@csie.org>
Message-ID: <20171205082721.imghrej2lt5tured@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 04, 2017 at 04:44:01PM +0800, Chen-Yu Tsai wrote:
> When the HDMI controller device node was added, the needed PLL clock
> macros were not exported. A separate patch addresses that, but it is
> merged through a different tree.
> 
> Now that both patches are in mainline proper, we can convert the raw
> numbers to proper macros.
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
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171205/5353fceb/attachment.sig>
