From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 19 Jan 2015 10:57:23 +0100
Subject: [PATCH v3 3/3] ARM: dts: sun5i: Add mk802_a10s board
In-Reply-To: <1421582985-26087-3-git-send-email-hdegoede@redhat.com>
References: <1421582985-26087-1-git-send-email-hdegoede@redhat.com>
 <1421582985-26087-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20150119095723.GC4367@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 18, 2015 at 01:09:45PM +0100, Hans de Goede wrote:
> The mk802_a10s re-uses is the "classic" mk802 case and functionality, but has
> an A10s SoC inside rather then the A10, it features 512M or 1G RAM, 4G nand,
> a mini-hdmi female connector, USB-A receptacle, mini-usb receptacle (OTG)
> and a sdio realtek wifi chip. Unlike the original mk802 it does have a pmic,
> the axp152.
> 
> For more details see: http://linux-sunxi.org/Semitime_g2
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied these three patches.

This patch was not applying properly because of the missing t004 DTS
in my tree.

I also change the board compatible to a10s-mk802, to match what we
have with other boards in a similar case (olinuxinos, pcduinos,
cubieboards, etc.), and dropped the _a10s from the pinctrl nodes for
the same reasons.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150119/842e3c30/attachment.sig>
