From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 5 Sep 2018 09:21:20 +0200
Subject: [PATCH v4 05/11] drm/sun4i: Add support for A64 display engine
In-Reply-To: <20180904044053.15425-6-icenowy@aosc.io>
References: <20180904044053.15425-1-icenowy@aosc.io>
 <20180904044053.15425-6-icenowy@aosc.io>
Message-ID: <20180905072120.nejhsauwvocc3nhw@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2018 at 12:40:47PM +0800, Icenowy Zheng wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
> 
> Display Engine(DE2) in Allwinner A64 has two mixers and tcons.
> 
> The routing for mixer0 is through tcon0 and connected to
> LVDS/RGB/MIPI-DSI controller.
> 
> The routing for mixer1 is through tcon1 and connected to HDMI.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180905/30594f96/attachment.sig>
