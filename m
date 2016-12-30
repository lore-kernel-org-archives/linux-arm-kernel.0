From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 30 Dec 2016 11:01:18 +0800
Subject: [PATCH v2] ARM: dts: imx6qdl-nitrogen6x: remove duplicate iomux
 entry
In-Reply-To: <20161124234247.18397-1-gary.bisson@boundarydevices.com>
References: <20161124231638.12840-1-gary.bisson@boundarydevices.com>
 <20161124234247.18397-1-gary.bisson@boundarydevices.com>
Message-ID: <20161230030116.GM6177@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2016 at 12:42:47AM +0100, Gary Bisson wrote:
> The NANDF_CS2 pad is also part of the wlan-vmmcgrp iomux group.
> 
> Removing is from the usdhc2grp group avoids the following error:
> imx6q-pinctrl 20e0000.iomuxc: pin MX6Q_PAD_NANDF_CS2 already requested
> by regulators:regulator at 4; cannot claim for 2194000.usdhc
> imx6q-pinctrl 20e0000.iomuxc: pin-187 (2194000.usdhc) status -22
> imx6q-pinctrl 20e0000.iomuxc: could not request pin 187
> (MX6Q_PAD_NANDF_CS2) from group usdhc2grp on device 20e0000.iomuxc
> 
> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>

Applied, thanks.
