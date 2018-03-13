From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 13 Mar 2018 09:03:32 +0800
Subject: [PATCH] clk: imx6ull: Add epdc_podf instead of sim_podf
In-Reply-To: <64c4bc079a59002931a92e00b38b455d957ce169.1520866479.git.leonard.crestez@nxp.com>
References: <64c4bc079a59002931a92e00b38b455d957ce169.1520866479.git.leonard.crestez@nxp.com>
Message-ID: <20180313010331.GE26859@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2018 at 04:59:25PM +0200, Leonard Crestez wrote:
> This is one of the differences between 6ul and 6ull: imx6ull has no sim
> but has epdc and this clock is redefined on the same bit.
> 
> This can be verified in the Reference Manuals.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied, thanks.
