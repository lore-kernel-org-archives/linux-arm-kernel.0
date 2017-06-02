From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 2 Jun 2017 15:47:18 +0530
Subject: [PATCH v2 0/4] fix some issues for Rockchip usb2-phy and add
 rk3228 SoCs' support
In-Reply-To: <1496373626-27856-1-git-send-email-frank.wang@rock-chips.com>
References: <1496373626-27856-1-git-send-email-frank.wang@rock-chips.com>
Message-ID: <711e89a3-0f55-7458-2e4f-589d719a0548@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 02 June 2017 08:50 AM, Frank Wang wrote:
> These series of patches fix some issues for rockchip usb2-phy and amend
> usb2-phy framework to support one phy which comprises with two host-ports.
> 
> In addition, this change also add rk3228 usb2-phy support.

merged, thanks!

-Kishon
> 
> Changes from v1:
>  - Replaced rk322x with rk3228 for PATCH 4/4.
>  - Included devicetree people in the recipient list.
> 
> Frank Wang (1):
>   phy: rockchip-inno-usb2: add support of usb2-phy for rk3228 SoCs
> 
> William Wu (3):
>   phy: rockchip-inno-usb2: add a delay after phy resume
>   phy: rockchip-inno-usb2: increase otg sm work first schedule time
>   phy: rockchip-inno-usb2: add one phy comprises with two host-ports
>     support
> 
>  .../bindings/phy/phy-rockchip-inno-usb2.txt        |  1 +
>  drivers/phy/phy-rockchip-inno-usb2.c               | 74 ++++++++++++++++++++--
>  2 files changed, 71 insertions(+), 4 deletions(-)
> 
