From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 5 Sep 2018 09:22:05 +0200
Subject: [PATCH v4 09/11] dt-bindings: sun4i-drm: add HDMI VCC supply
 property for sun8i-dw-hdmi
In-Reply-To: <20180904044053.15425-10-icenowy@aosc.io>
References: <20180904044053.15425-1-icenowy@aosc.io>
 <20180904044053.15425-10-icenowy@aosc.io>
Message-ID: <20180905072205.63qmmqr45323xllc@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2018 at 12:40:51PM +0800, Icenowy Zheng wrote:
> Allwiner SoCs with DesignWare HDMI controller all come with a "HVCC"
> pin, which is the VCC of HDMI part.
> 
> Add a supply property to specify HVCC's regulator in the device tree.
> 
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180905/2bc344ac/attachment.sig>
