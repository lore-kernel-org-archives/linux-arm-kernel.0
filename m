From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 5 Jan 2017 18:14:06 +0100
Subject: [PATCH] ARM: dts: sunxi: Use axp209.dtsi for Olinuxino Lime2
In-Reply-To: <20161227102238.20110-1-manu@bidouilliste.com>
References: <20161227102238.20110-1-manu@bidouilliste.com>
Message-ID: <20170105171406.s5xpbtcpe4esn6iz@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 27, 2016 at 11:22:38AM +0100, Emmanuel Vadot wrote:
> Use axp209.dtsi in sun7i-a20-olinuxino-lime2.dts and correct
> some regulators.
> 
> DCDC2 is used for vdd-cpu so it should never be bellow 1V and above 1.4V
> DCDC3 is used for VDD_INT so same as above.
> LD01 is used for the RTC, and should have a typical value of 1.3V
> LD02 is used for AVCC and should have a typical value of 3.0V
> LD03/4 are used for Port-E/Port-G Power pin, and the schematics recommands
> to set them to 2.8V as they can be used for CSI0/1.
> 
> Signed-off-by: Emmanuel Vadot <manu@bidouilliste.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170105/3536d00f/attachment.sig>
