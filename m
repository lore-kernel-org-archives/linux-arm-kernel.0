From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 18 Feb 2016 21:35:39 +0800
Subject: [PATCH] ARM: dts: imx6qdl-microsom.dtsi: avoid boot-time UHS
 warning
In-Reply-To: <E1aVMgw-0001wE-5w@rmk-PC.arm.linux.org.uk>
References: <E1aVMgw-0001wE-5w@rmk-PC.arm.linux.org.uk>
Message-ID: <20160218133539.GW6756@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 05:12:06PM +0000, Russell King wrote:
> Avoid the following warning:
> 
> sdhci-esdhc-imx 2190000.usdhc: could not get ultra high speed state, work on normal mode
> 
> which occurs at boot each time the SDHCI interface for the Broadcom
> WiFi is probed.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Not sure why you resend, but I already applied the following series you
sent on Jan. 27 [1].

[PATCH 1/3] ARM: dts: imx6qdl-microsom.dtsi: avoid boot-time UHS warning
[PATCH 2/3] ARM: dts: imx6*-hummingboard: use proper gpio flags definitions
[PATCH 3/3] ARM: dts: imx6*-hummingboard: fix pcie reset GPIO specification

Shawn

[1] http://permalink.gmane.org/gmane.linux.drivers.devicetree/154097
