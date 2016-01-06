From: robh@kernel.org (Rob Herring)
Date: Wed, 6 Jan 2016 09:08:00 -0600
Subject: [PATCH v2 2/6] dt-bindings: ARM: Mediatek: Document bindings for
 MT2701
In-Reply-To: <1451975422-31174-3-git-send-email-jamesjj.liao@mediatek.com>
References: <1451975422-31174-1-git-send-email-jamesjj.liao@mediatek.com>
 <1451975422-31174-3-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <20160106150800.GA941@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05, 2016 at 02:30:18PM +0800, James Liao wrote:
> This patch adds the binding documentation for apmixedsys, bdpsys,
> ethsys, hifsys, imgsys, infracfg, mmsys, pericfg, topckgen and
> vdecsys for Mediatek MT2701.
> 
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>

[...]

> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt
> new file mode 100644
> index 0000000..4137196
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,bdpsys.txt
> @@ -0,0 +1,22 @@
> +Mediatek bdpsys controller
> +============================
> +
> +The Mediatek bdpsys controller provides various clocks to the system.
> +
> +Required Properties:
> +
> +- compatible: Should be:
> +	- "mediatek,mt2701-bdpsys", "syscon"

If this block and others only provide clocks, then why do you need 
syscon here? If it is more that clocks, then the description is wrong.

Rob
