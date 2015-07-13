From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 13 Jul 2015 07:45:49 +0200
Subject: [PATCH v3 0/3] Fixes for MT8173 PLLs
In-Reply-To: <1436517574-17895-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1436517574-17895-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <20150713054549.GC18700@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 10, 2015 at 04:39:31PM +0800, James Liao wrote:
> Title changed. Previous title is "Add MT8173 MMPLL change rate support"
> and can be found in [1].
> 
> This patchset contains some fixes for changing rate of PLLs, especially
> for MMPLL.
> 
> The first 2 patches are common fixes for PLLs, and the last patch is a
> fix to support MT8173 MMPLL changing rate because its frequency setting
> is different from other PLLs.
> 
> changes since v2:
> - Rebase to 4.2-rc1.
> - Split fixes of PLL setting calculation to a separeted patch.
> 
> changes since v1:
> - Add a separated patch for mtk_pll_set_rate_regs().
> - Use a structure array to describe a div_table.
> - Limit max frequency to div_table[0].
> - Minor changes such as static and comments.
> 
> [1] https://lkml.org/lkml/2015/7/8/265
> 
> James Liao (3):
>   clk: mediatek: Fix PLL registers setting flow
>   clk: mediatek: Fix calculation of PLL rate settings
>   clk: mediatek: Add MT8173 MMPLL change rate support

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
