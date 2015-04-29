From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 29 Apr 2015 08:37:26 +0200
Subject: [PATCH v3 4/7] arm64: dts: mediatek: Add MT8173 MMC dts
In-Reply-To: <1430214525-19198-5-git-send-email-chaotian.jing@mediatek.com>
References: <1430214525-19198-1-git-send-email-chaotian.jing@mediatek.com>
 <1430214525-19198-5-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <20150429063726.GQ6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 28, 2015 at 05:48:42PM +0800, Chaotian Jing wrote:
> From: Eddie Huang <eddie.huang@mediatek.com>
> 
> Add node mmc0 and mmc1

While at it you could add mmc2 and mmc3 to the dtsi aswell. No need to patch that
again later.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
