From: shengjiu.wang@freescale.com (Shengjiu Wang)
Date: Sat, 10 Oct 2015 09:45:54 +0800
Subject: [PATCH V2 1/2] clk: imx6: Add SPDIF_GCLK clock in clock tree
In-Reply-To: <20151010011155.GH22673@tiger>
References: <cover.1442310569.git.shengjiu.wang@freescale.com>
 <113f1cecf1d83c6b96fd23ab9d7a73d1923e0d21.1442310569.git.shengjiu.wang@freescale.com>
 <20150923153340.GK3529@tiger> <20150924054321.GA32196@shlinux2>
 <20150924115737.GM3529@tiger> <20151009091528.GA25804@shlinux2>
 <20151010011155.GH22673@tiger>
Message-ID: <20151010014553.GB25804@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 10, 2015 at 09:11:55AM +0800, Shawn Guo wrote:
> On Fri, Oct 09, 2015 at 05:15:30PM +0800, Shengjiu Wang wrote:
> > SPDIF_GCLK is also spdif's clock, it use a same enable bit with SPDIF_ROOT_CLK,
> > We didn't separate them in clock tree before.
> 
> Is it the clock described as "Global clock" in Reference Manual, SPDIF
Yes.
> chapter?  If that's the case, you are just adding a missing SPDIF clock
> rather than fixing a low power mode issue, and I will be fine.  But
> still you should reword the commit log to make it clear, that the patch
> is to correct a SPDIF clock setting issue, which is just discovered by
> low power mode support.
> 
Ok, I will refine the patch comments, and send it later.

> Shawn
