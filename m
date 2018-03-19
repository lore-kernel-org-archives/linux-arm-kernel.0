From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 19 Mar 2018 15:16:53 +0530
Subject: [PATCH net-next 04/10] phy: add 2.5G SGMII mode to the phy_mode
 enum
In-Reply-To: <20180316103351.16616-5-antoine.tenart@bootlin.com>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-5-antoine.tenart@bootlin.com>
Message-ID: <8b8ffdcb-f365-09c6-24f2-7fcebe3b5f76@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 16 March 2018 04:03 PM, Antoine Tenart wrote:
> This patch adds one more generic PHY mode to the phy_mode enum, to allow
> configuring generic PHYs to the 2.5G SGMII mode by using the set_mode
> callback.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  include/linux/phy/phy.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index 4f8423a948d5..5a80e9de3686 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -28,6 +28,7 @@ enum phy_mode {
>  	PHY_MODE_USB_DEVICE,
>  	PHY_MODE_USB_OTG,
>  	PHY_MODE_SGMII,
> +	PHY_MODE_2500SGMII,
>  	PHY_MODE_10GKR,
>  	PHY_MODE_UFS_HS_A,
>  	PHY_MODE_UFS_HS_B,
> 
