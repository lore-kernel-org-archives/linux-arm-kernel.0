From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 5 Sep 2018 09:21:36 +0200
Subject: [PATCH v4 06/11] dt-bindings: display: Add compatible for A64 HDMI
In-Reply-To: <20180904044053.15425-7-icenowy@aosc.io>
References: <20180904044053.15425-1-icenowy@aosc.io>
 <20180904044053.15425-7-icenowy@aosc.io>
Message-ID: <20180905072136.kzky22gkpkvjh35z@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2018 at 12:40:48PM +0800, Icenowy Zheng wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
> 
> The HDMI controller on Allwinner A64 is similar on the one on
> H3/H5/A83T (although the PHY is different with A83T).
> 
> Add A64 compatible and append A83T compatible as fallback.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> [Icenowy: refactor commit log]
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180905/ae326d02/attachment.sig>
