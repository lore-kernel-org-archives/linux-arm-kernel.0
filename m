From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 18 Feb 2014 10:22:15 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select CONFIG_DEBUG_FS
In-Reply-To: <1392659460-6821-1-git-send-email-fabio.estevam@freescale.com>
References: <1392659460-6821-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20140218022214.GC15716@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 02:51:00PM -0300, Fabio Estevam wrote:
> CONFIG_DEBUG_FS is a very useful debug option as it allow us to access key
> data such as the clock tree, for example:
> 
> mount -t debugfs debugfs /sys/kernel/debug
> cat /sys/kernel/debug/clk/clk_summary
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks. 
