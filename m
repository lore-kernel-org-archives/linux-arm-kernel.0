From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 5 Sep 2018 09:20:51 +0200
Subject: [PATCH v4 03/11] dt-bindings: display: Add compatible for A64
 DE2 display pipeline
In-Reply-To: <20180904044053.15425-4-icenowy@aosc.io>
References: <20180904044053.15425-1-icenowy@aosc.io>
 <20180904044053.15425-4-icenowy@aosc.io>
Message-ID: <20180905072051.ac7nfa4f65gcqaf7@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2018 at 12:40:45PM +0800, Icenowy Zheng wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
> 
> Allwinner A64 has a DE2 display pipeline. The TCONs are similar to the
> ones in A83T, but the mixers are new (similar to the later R40 SoC).
> 
> This patch adds dt-binding documentation for A64 DE2 display pipeline.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> [Icenowy: Refactor and also cover TCON1]
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180905/c188707d/attachment.sig>
