From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 5 Apr 2017 09:03:51 +0200
Subject: [PATCH 1/3] phy: sun4i-usb: enable PHY0 dual route switching for
 A64 USB PHY
In-Reply-To: <20170404184518.33610-1-icenowy@aosc.io>
References: <20170404184518.33610-1-icenowy@aosc.io>
Message-ID: <20170405070351.etpupeqjeo7dhyxl@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 05, 2017 at 02:45:16AM +0800, Icenowy Zheng wrote:
> Allwinner A64 SoC features a switchable PHY0 like the one in H3, which
> can switch between a MUSB controller and a pair of OHCI/EHCI controller.
> 
> Enable PHY0 route auto switching for A64.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170405/8945baea/attachment.sig>
