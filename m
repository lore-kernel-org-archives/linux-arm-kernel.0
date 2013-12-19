From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 19 Dec 2013 15:06:16 +0800
Subject: [PATCH 1/3] ARM: dts: imx6qdl: add necessary thermal clk
In-Reply-To: <1387477045-19037-1-git-send-email-b20788@freescale.com>
References: <1387477045-19037-1-git-send-email-b20788@freescale.com>
Message-ID: <20131219070615.GC6691@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 01:17:23PM -0500, Anson Huang wrote:
> Thermal sensor needs pll3_usb_otg when measuring temperature,
> so we need to pass clk info to thermal driver.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Applied this one, thanks.
