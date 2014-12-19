From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 19 Dec 2014 18:57:57 +0100
Subject: [PATCH] ARM: dts: sunxi: Fix usb-phy support for sun4i/sun5i
In-Reply-To: <1418901035-22900-1-git-send-email-wens@csie.org>
References: <1418901035-22900-1-git-send-email-wens@csie.org>
Message-ID: <20141219175757.GN4820@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 18, 2014 at 07:10:35PM +0800, Chen-Yu Tsai wrote:
> usbphy0 support in the sunxi usb-phy driver has been merged, but the
> dtsi's for sun4i/sun5i haven't been updated. This results in the phy
> driver failing to load, breaking usb support.
> 
> Fixes: 6827a46f5994 ('phy: sun4i: add support for USB phy0')
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> Hi Maxime,
> 
> The phy-sun4i-usb usbphy0 update is merged into Linus's tree.
> Please queue this one for 3.19 fixes.

Applied, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141219/f2ae0d21/attachment-0001.sig>
