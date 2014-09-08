From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 8 Sep 2014 09:23:41 +0200
Subject: [PATCH 2/5] arm: mediatek: add dts for 8127 Moose board
In-Reply-To: <1409874660-8710-3-git-send-email-srv_yingjoe.chen@mediatek.com>
References: <1409874660-8710-1-git-send-email-srv_yingjoe.chen@mediatek.com>
 <1409874660-8710-3-git-send-email-srv_yingjoe.chen@mediatek.com>
Message-ID: <20140908072341.GA15722@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 05, 2014 at 07:50:57AM +0800, Joe.C wrote:
> From: "Joe.C" <yingjoe.chen@mediatek.com>
> 
> Moose is a tablet evalutation board based on MT8127 SoC.
> 
> Signed-off-by: Joe.C <yingjoe.chen@mediatek.com>
> ---
>  arch/arm/boot/dts/mt8127-moose.dts | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 arch/arm/boot/dts/mt8127-moose.dts

You could add this and the other dts files to
dtb-$(CONFIG_ARCH_MEDIATEK) so the Mediatek device trees are compile
during the build

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
