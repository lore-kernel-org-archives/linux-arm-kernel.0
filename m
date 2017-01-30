From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Jan 2017 10:06:59 +0100
Subject: [PATCH v3 05/10] arm: dts: sun8i: split Allwinner H3 .dtsi
In-Reply-To: <20170129023331.62106-6-icenowy@aosc.xyz>
References: <20170129023331.62106-1-icenowy@aosc.xyz>
 <20170129023331.62106-6-icenowy@aosc.xyz>
Message-ID: <20170130090659.m7nv3z7mji2dhcsc@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 29, 2017 at 10:33:26AM +0800, Icenowy Zheng wrote:
> +#include <dt-bindings/clock/sunxi-h3-h5-ccu.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/pinctrl/sun4i-a10.h>
> +#include <dt-bindings/reset/sunxi-h3-h5-ccu.h>

You're also converting to the new headers you created. This should be
part of a separate patch, or merged with your next one.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170130/b865edb1/attachment.sig>
