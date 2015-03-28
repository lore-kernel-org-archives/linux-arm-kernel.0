From: marex@denx.de (Marek Vasut)
Date: Sat, 28 Mar 2015 16:33:02 +0100
Subject: [PATCH 2/2] phy: driver for Conexant Digicolor internal USB PHY
In-Reply-To: <4a9ceb0a240d49dd6a68d50c78f85d310d4b932f.1427430989.git.baruch@tkos.co.il>
References: <6284a7672647d46100281959552f9787f98bb552.1427430989.git.baruch@tkos.co.il>
 <4a9ceb0a240d49dd6a68d50c78f85d310d4b932f.1427430989.git.baruch@tkos.co.il>
Message-ID: <201503281633.02801.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, March 27, 2015 at 05:36:29 AM, Baruch Siach wrote:
> Add a driver for the USB PHY on the Conexant CX92755 SoC, from the
> Digicolor series of SoCs. The PHY is connected to the on-chip chipidea
> usb2 host.
> 
> The hardware is somewhat similar to the phy-mxs-usb.c usb_phy, but it is
> different enough to merit its own driver. Also, this driver uses the
> generic phy infrastructure.

Hi,

the register set looks very similar to MXS one indeed. How is it different 
please ?

The driver looks OK.

Best regards,
Marek Vasut
