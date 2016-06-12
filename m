From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 12 Jun 2016 19:31:05 +0800
Subject: [PATCH 03/11] clk: imx7d: correct dram root clk parent select
In-Reply-To: <1465396420-27064-3-git-send-email-aisheng.dong@nxp.com>
References: <1465396420-27064-1-git-send-email-aisheng.dong@nxp.com>
 <1465396420-27064-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20160612113105.GA20243@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 10:33:32PM +0800, Dong Aisheng wrote:
> From: Anson Huang <b20788@freescale.com>
> 
> DRAM root clk should be either from pll dram main clk
> or dram alt root clk.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Applied, thanks.
