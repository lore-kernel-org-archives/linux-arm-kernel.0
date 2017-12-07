From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 7 Dec 2017 10:03:11 +0100
Subject: [PATCH v2] ARM: dts: sun8i: h3: enable USB OTG for NanoPi Neo
 board
In-Reply-To: <20171205220358.GA28161@t440.localdomain>
References: <20171205090706.et5a7dizkhn6auje@flea.lan>
 <20171205220358.GA28161@t440.localdomain>
Message-ID: <20171207090311.deat4rvbthye4b52@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 05, 2017 at 11:03:58PM +0100, Krzysztof Adamski wrote:
> Similarly to Orange Pi Zero, NanoPi Neo board has an USB OTG port with
> an ID pin but with unpowered VBUS. This patch enables this port in
> forced peripheral mode.
> 
> ohci/ehci nodes are still enabled since the host mode may work if
> external power source is used. In that case, the mode can be switched
> for example via sysfs. The same strategy is used for Orange Pi Zero
> board DTS.
> 
> Signed-off-by: Krzysztof Adamski <k@japko.eu>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171207/822b4291/attachment.sig>
