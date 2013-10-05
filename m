From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 5 Oct 2013 14:52:44 +0800
Subject: [PATCH 1/3] ARM: mach-imx: clk-imx51-imx53: Retrieve base
 address and irq from dt
In-Reply-To: <1380597674-31122-1-git-send-email-festevam@gmail.com>
References: <1380597674-31122-1-git-send-email-festevam@gmail.com>
Message-ID: <20131005065242.GH2734@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 12:21:12AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> As mx53 is a dt-only SoC, we should retrieve the gpt base address and irq
> from the device tree, instead of using the old MX53_IO_ADDRESS method.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied all 3, thanks.
