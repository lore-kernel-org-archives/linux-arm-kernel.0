From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 3 May 2016 20:58:38 +0800
Subject: [PATCH 1/2] ARM: imx_v6_v7_defconfig: add CONFIG_I2C_GPIO
In-Reply-To: <1461962419-4715-1-git-send-email-marcel.ziswiler@toradex.com>
References: <1461962419-4715-1-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <20160503125838.GL5874@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2016 at 10:40:18PM +0200, Marcel Ziswiler wrote:
> The GPIO-based bitbanging I2C driver is required to make HDMI work on
> the Apalis iMX6 module plugged into a Ixora carrier board featuring a
> DDC channel to read a screen's EDID being hooked up to regular GPIOs.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Applied both, thanks.
