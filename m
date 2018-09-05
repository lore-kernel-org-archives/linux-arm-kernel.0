From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 5 Sep 2018 09:21:51 +0200
Subject: [PATCH v4 07/11] dt-bindings: clock: sun50i-a64-ccu: Add
 PLL_VIDEO0 macro
In-Reply-To: <20180904044053.15425-8-icenowy@aosc.io>
References: <20180904044053.15425-1-icenowy@aosc.io>
 <20180904044053.15425-8-icenowy@aosc.io>
Message-ID: <20180905072151.3jqfpzuawyohov3f@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2018 at 12:40:49PM +0800, Icenowy Zheng wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
> 
> Allwinner A64 HDMI PHY clock has PLL_VIDEO0 as a parent.
> 
> Include the macro on dt-bindings so-that the same can be used
> while defining CCU clock phandles.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180905/09564f84/attachment.sig>
