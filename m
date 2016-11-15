From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 15 Nov 2016 18:30:27 +0530
Subject: [PATCH v4 0/2] phy: rockchip-inno-usb2: correct 480MHz clk_ops
 callbacks and stable time
In-Reply-To: <1479182047-3399-1-git-send-email-wulf@rock-chips.com>
References: <1479182047-3399-1-git-send-email-wulf@rock-chips.com>
Message-ID: <582B06EB.1050700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 15 November 2016 09:24 AM, William Wu wrote:
> This series try to correct the 480MHz output clock of USB2 PHY
> clk_ops callback and fix the delay time. It aims to make the
> 480MHz clock gate more sensible and stable.
> 
> Tested on rk3366/rk3399 EVB board.

merged to phy -next.

Thanks
Kishon
> 
> William Wu (2):
>   phy: rockchip-inno-usb2: correct clk_ops callback
>   phy: rockchip-inno-usb2: correct 480MHz output clock stable time
> 
>  drivers/phy/phy-rockchip-inno-usb2.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
