From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 28 Jan 2015 08:48:38 +0100
Subject: [PATCH v5 2/5] dt-bindings: Add pinctrl bindings for
 mt65xx/mt81xx.
In-Reply-To: <1421818097-9281-3-git-send-email-hongzhou.yang@mediatek.com>
References: <1421818097-9281-1-git-send-email-hongzhou.yang@mediatek.com>
 <1421818097-9281-3-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <20150128074838.GX12209@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 21, 2015 at 01:28:14PM +0800, Hongzhou Yang wrote:
> From: Hongzhou Yang <hongzhou.yang@mediatek.com>
> 
> Add devicetree bindings for Mediatek SoC pinctrl driver.
> 
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>

This basically follows the pinmux binding I suggested as generic pinmux
binding for per-pin type controllers, so:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
