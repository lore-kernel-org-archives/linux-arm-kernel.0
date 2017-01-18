From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 18 Jan 2017 08:11:06 +0100
Subject: [PATCH] ARM: dts: sun6i: sina31s: Enable USB OTG controller in
 peripheral mode
In-Reply-To: <20170118010105.20069-1-wens@csie.org>
References: <20170118010105.20069-1-wens@csie.org>
Message-ID: <20170118071106.oynmjovrik54fjwy@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 09:01:05AM +0800, Chen-Yu Tsai wrote:
> While the SinA31s does have a proper 5-pin mini USB OTG port, the ID
> pin does not seem to work. The pin used in the schematics is always low,
> regardless of the attached OTG cable or SoC internal pin bias settings.
> 
> The v1.5 board is missing bias resistors shown in the schematics for
> earlier revisions, and the connections of the remaining one does not
> match the schematics either.
> 
> In addition, VBUS for this port is disconnected from the board's 5V
> power rail. The board features a pad to solder jumper pins to connect
> VBUS to 5V manually.
> 
> Given the above and the fact that the board has 5 more USB host ports,
> it makes more sense to have the OTG port work in peripheral mode.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170118/ebeebfd8/attachment.sig>
