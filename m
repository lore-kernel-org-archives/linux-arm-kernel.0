From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 20 Mar 2017 09:31:23 +0100
Subject: [PATCH] ARM: sun8i: a23/a33: drop bl_en_pin GPIO pinmux in
 reference design DTSI
In-Reply-To: <20170317212315.2561-1-icenowy@aosc.xyz>
References: <20170317212315.2561-1-icenowy@aosc.xyz>
Message-ID: <20170320083123.qwetsg6hxjbylmai@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 18, 2017 at 05:23:15AM +0800, Icenowy Zheng wrote:
> The bl_en_pin GPIO pinmux is configured as "gpio_in", which makes it
> conflicts with the real GPIO usage (out), and makes the backlight not
> usable.
> 
> Drop the GPIO pinmux for it, thus this GPIO can be correctly used.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/668912a0/attachment.sig>
