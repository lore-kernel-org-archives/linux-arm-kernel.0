From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 24 Nov 2016 20:53:48 +0100
Subject: [RFC PATCH 2/2] arm64: dts: enable the MUSB controller of Pine64
 in host-only mode
In-Reply-To: <20161122165902.62543-2-icenowy@aosc.xyz>
References: <20161122165902.62543-1-icenowy@aosc.xyz>
 <20161122165902.62543-2-icenowy@aosc.xyz>
Message-ID: <20161124195348.t53xxasm6hlvwz7s@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2016 at 12:59:02AM +0800, Icenowy Zheng wrote:
> A64 has a MUSB controller wired to the USB PHY 0, which is connected
> to the upper USB Type-A port of Pine64.
> 
> As the port is a Type-A female port, enable it in host-only mode in the
> device tree, which makes devices with USB Type-A male port can work on
> this port (which is originally designed by Pine64 team).
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Applied both, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161124/7504c3f1/attachment.sig>
