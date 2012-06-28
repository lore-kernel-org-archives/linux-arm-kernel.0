From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Thu, 28 Jun 2012 19:23:37 +0800
Subject: [PATCH v2 1/2] net: flexcan: clock-frequency is optional for
 device tree probe
In-Reply-To: <1340853701-4488-2-git-send-email-shawn.guo@linaro.org>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
 <1340853701-4488-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120628112336.GI6406@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2012 at 11:21:40AM +0800, Shawn Guo wrote:
> The property clock-frequency is optional for device tree probe.  When
> it's absent, the flexcan driver will try to get the frequency from clk
> system by calling clk_get_rate.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Regards
Dong Aisheng
