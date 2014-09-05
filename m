From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 5 Sep 2014 08:43:47 +0800
Subject: [PATCH V1 1/2] ARM: clk-imx6q: refine clock tree for ASRC
In-Reply-To: <98d2985de76fa84525e9958522bd371a34ff84f0.1409824001.git.shengjiu.wang@freescale.com>
References: <98d2985de76fa84525e9958522bd371a34ff84f0.1409824001.git.shengjiu.wang@freescale.com>
Message-ID: <20140905004346.GF10809@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 04, 2014 at 05:48:58PM +0800, Shengjiu Wang wrote:
> ASRC has "asrc", "asrc_ipg", "asrc_mem" clocks, and they share
> the same gate bits.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>

Applied both, thanks.
