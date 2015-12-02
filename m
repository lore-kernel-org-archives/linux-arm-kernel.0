From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 2 Dec 2015 13:40:19 +0800
Subject: [PATCH 1/3] clk: imx: Add a virtual arm clk on i.mx7d
In-Reply-To: <1448360716-1741-1-git-send-email-b51503@freescale.com>
References: <1448360716-1741-1-git-send-email-b51503@freescale.com>
Message-ID: <20151202054019.GF692@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 06:25:14PM +0800, Bai Ping wrote:
> Add a virtual arm clk to abstract the actual steps
> when changing the ARM core frequency.So we can using
> the 'cpufreq-dt' driver on i.MX7D/Solo.
> 
> Signed-off-by: Bai Ping <b51503@freescale.com>

Applied all, thanks.
