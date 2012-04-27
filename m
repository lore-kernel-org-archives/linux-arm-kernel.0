From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 27 Apr 2012 13:30:09 +0800
Subject: [PATCH v3 2/4] pinctrl: pinctrl-imx: add imx pinctrl core driver
In-Reply-To: <1335451227-27709-2-git-send-email-b29396@freescale.com>
References: <1335451227-27709-1-git-send-email-b29396@freescale.com>
 <1335451227-27709-2-git-send-email-b29396@freescale.com>
Message-ID: <20120427053007.GH2234@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 10:40:25PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> The driver has mux and config support while the gpio is still
> not supported.
> For select input setting, the driver will handle it internally
> and do not need user to take care of it.
> 
> The pinctrl-imx core driver will parse the dts file and dynamically
> create the pinmux functions and groups.
> 
> Each IMX SoC pinctrl driver should register pins with a pin register map
> including mux register and config register and select input map to core
> for proper operations.
> 
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> 
Acked-by: Shawn Guo <shawn.guo@linaro.org>
