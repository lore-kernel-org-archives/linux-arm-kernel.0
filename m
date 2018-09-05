From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 05 Sep 2018 16:46:33 +0300
Subject: [PATCH 01/10] phy: Add MIPI D-PHY mode
In-Reply-To: <00e3d5da1ca3c03ba60350c1cf78ab44693ff493.1536138624.git-series.maxime.ripard@bootlin.com>
References: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com>
 <00e3d5da1ca3c03ba60350c1cf78ab44693ff493.1536138624.git-series.maxime.ripard@bootlin.com>
Message-ID: <2567966.N4s79vZLWV@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Thank you for the patch.

On Wednesday, 5 September 2018 12:16:32 EEST Maxime Ripard wrote:
> MIPI D-PHY is a MIPI standard meant mostly for display and cameras in
> embedded systems. Add a mode for it.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  include/linux/phy/phy.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index 9713aebdd348..9cba7fe16c23 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -40,6 +40,7 @@ enum phy_mode {
>  	PHY_MODE_10GKR,
>  	PHY_MODE_UFS_HS_A,
>  	PHY_MODE_UFS_HS_B,
> +	PHY_MODE_MIPI_DPHY,
>  };
> 
>  /**

-- 
Regards,

Laurent Pinchart
