From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 23 Jan 2017 17:47:37 +0800
Subject: [PATCH v2 2/3] ARM: dts: imx6ul: Add Engicam Is.IoT MX6UL eMMC
 initial support
In-Reply-To: <1484867375-22411-2-git-send-email-jagan@openedev.com>
References: <1484867375-22411-1-git-send-email-jagan@openedev.com>
 <1484867375-22411-2-git-send-email-jagan@openedev.com>
Message-ID: <20170123094735.GO5662@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 12:09:34AM +0100, Jagan Teki wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
> 
> Engicam Is.IoT MX6UL has separate module for eMMC, so add emmc dts
> file for imx6ul-isiot.dtsi, usdhc2 node represent eMMC.
> 
> dmesg:
> -----
> mmc1: SDHCI controller on 2194000.usdhc [2194000.usdhc] using ADMA
> mmc1: new DDR MMC card at address 0001
> mmcblk1: mmc1:0001 M62704 3.53 GiB
> 
> Cc: Matteo Lisi <matteo.lisi@engicam.com>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> Cc: Signed-off-by: Shawn Guo <shawnguo@kernel.org>

You only want to Cc me, not sign it off for me.  I removed the it when
applying.

Shawn

> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
