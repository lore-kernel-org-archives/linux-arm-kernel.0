From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 26 May 2015 09:56:43 +0200
Subject: [PATCH 3/5] dt-bindings: ARM: Mediatek: Document devicetree
 bindings for clock controllers
In-Reply-To: <1432192376-6712-4-git-send-email-jamesjj.liao@mediatek.com>
References: <1432192376-6712-1-git-send-email-jamesjj.liao@mediatek.com>
 <1432192376-6712-4-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <20150526075643.GF6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 03:12:54PM +0800, James Liao wrote:
> This adds the binding documentation for the mmsys, imgsys, vdecsys,
> vencsys and vencltsys controllers found on Mediatek SoCs.
> 
> index 0000000..a5b94a7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vdecsys.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencltsys.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vencsys.txt

Do these really become multiple drivers so that it's worth abstracting
them in the clock framework?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
