From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 26 May 2015 09:42:55 +0200
Subject: [PATCH 1/5] clk: mediatek: Fix apmixedsys clock registration
In-Reply-To: <1432192376-6712-2-git-send-email-jamesjj.liao@mediatek.com>
References: <1432192376-6712-1-git-send-email-jamesjj.liao@mediatek.com>
 <1432192376-6712-2-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <20150526074255.GD6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 03:12:52PM +0800, James Liao wrote:
> The size of clk_data should be the same as CLK_APMIXED_NR_CLK
> instead of ARRAY_SIZE(plls). CLK_APMIXED_* is numbered from 1, so
> CLK_APMIXED_NR_CLK will be greater than ARRAY_SIZE(plls).
> 
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
