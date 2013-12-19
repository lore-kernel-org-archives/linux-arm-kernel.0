From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 19 Dec 2013 10:44:19 +0800
Subject: [PATCH 1/2] ARM: dts: mxs: Add iio-hwmon to mx28 soc
In-Reply-To: <1387392656-28037-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1387392656-28037-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20131219024417.GN6691@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 07:50:55PM +0100, Alexandre Belloni wrote:
> This allows to read the SoC on-die temperature sensor available on the LRADC by
> using:
>  cat /sys/class/hwmon/hwmon0/device/temp1_input
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Applied both, thanks.
