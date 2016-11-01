From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 1 Nov 2016 19:46:39 +0100
Subject: [PATCH v3 2/6] net: phy: broadcom: Add BCM54810 PHY entry
In-Reply-To: <1478022694-25308-3-git-send-email-jon.mason@broadcom.com>
References: <1478022694-25308-1-git-send-email-jon.mason@broadcom.com>
 <1478022694-25308-3-git-send-email-jon.mason@broadcom.com>
Message-ID: <20161101184639.GI10785@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon

> @@ -56,6 +57,8 @@
>  #define PHY_BRCM_EXT_IBND_TX_ENABLE	0x00002000
>  #define PHY_BRCM_CLEAR_RGMII_MODE	0x00004000
>  #define PHY_BRCM_DIS_TXCRXC_NOENRGY	0x00008000
> +#define PHY_BRCM_EXP_LANE_SWAP		0x00010000
> +

You define this, but don't use it...

    Andrew
