From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 24 Feb 2014 10:11:39 +0800
Subject: [PATCH v2] ARM: mach-imx: Kconfig: Remove
 IMX_HAVE_PLATFORM_IMX2_WDT from SOC_IMX53
In-Reply-To: <1393021300-5964-1-git-send-email-festevam@gmail.com>
References: <1393021300-5964-1-git-send-email-festevam@gmail.com>
Message-ID: <20140224021138.GC25011@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 07:21:40PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> SOC_IMX53 is a device-tree only platform, so we don't need 
> IMX_HAVE_PLATFORM_IMX2_WDT at all because this symbol only provides some code 
> to help register imx2-wdt platform devices.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
