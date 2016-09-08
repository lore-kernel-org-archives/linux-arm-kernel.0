From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 8 Sep 2016 22:23:20 +0200
Subject: [PATCH] ARM: dts: sun8i: Move A23/A33 usbphy and usb_otg nodes
 to common dtsi
In-Reply-To: <20160908032535.12987-1-wens@csie.org>
References: <20160908032535.12987-1-wens@csie.org>
Message-ID: <20160908202320.GU8913@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 08, 2016 at 11:25:35AM +0800, Chen-Yu Tsai wrote:
> The usbphy and usb_otg nodes in the A23 and A33 dts files only differ
> by compatible, and for the usbphy, the size of one of its register
> regions.
> 
> Move all the common bits to the A23/A33 common dtsi file.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> Hi Maxime,
> 
> This patch applies on top of your A23/A33 CCU patches.

It was not applying properly. I think I did the proper fixup, but
you'll probably want to double check.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160908/b161d038/attachment.sig>
