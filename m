From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 08 Jul 2015 10:58:55 +0200
Subject: [PATCH v2 1/2] clk: mediatek: Fix PLL registers setting flow
In-Reply-To: <1436344666-25645-2-git-send-email-jamesjj.liao@mediatek.com>
References: <1436344666-25645-1-git-send-email-jamesjj.liao@mediatek.com>
 <1436344666-25645-2-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <79801022.IfOq8aeLEc@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 8. Juli 2015, 16:37:45 schrieb James Liao:
> Write postdiv and pcw settings at the same time for PLLs if postdiv
> and pcw settings are on the same register.
> 
> This is need by PLLs such as MT8173 MMPLL and ARM*PLL.
> 
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
