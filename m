From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 3 Apr 2013 13:27:34 +0800
Subject: [PATCH] pinctrl: imx5: fix SD2_DATA1 pad AUDMUX_AUD4 configuration
In-Reply-To: <1364948425-15372-1-git-send-email-marex@denx.de>
References: <1364948425-15372-1-git-send-email-marex@denx.de>
Message-ID: <20130403052732.GP24039@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 03, 2013 at 02:20:25AM +0200, Marek Vasut wrote:
> The IOMUXC_AUDMUX_P4_INPUT_TXCLK_AMX_SELECT_INPUT must be configured as 1
> instead of 0 to have AUD4 muxed on SD2 pins working.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Changed the prefix to "ARM: dts: imx53: " and applied the patch.

Shawn
