From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 24 May 2013 13:42:01 +0800
Subject: [PATCH] ARM: dts: imx: fix clocks for cspi
In-Reply-To: <1369309085-31146-1-git-send-email-jonas@microbit.se>
References: <1369309085-31146-1-git-send-email-jonas@microbit.se>
Message-ID: <20130524054159.GF2704@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 01:38:05PM +0200, Jonas Andersson wrote:
> The CSPI controller has only one clock, but the driver spi-imx.c needs clock "per" to calculate bitrate divisor.
> 
> Signed-off-by: Jonas Andersson <jonas@microbit.se>

Applied, thanks.
