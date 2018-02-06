From: a.hajda@samsung.com (Andrzej Hajda)
Date: Tue, 06 Feb 2018 14:06:58 +0100
Subject: [PATCH v2] drm/bridge/synopsys: dsi: Add 1.31 version support
In-Reply-To: <20180206084251.303-1-philippe.cornu@st.com>
References: <CGME20180206084357epcas1p32e11d1e3c84de7da9d5ba150ded77cdf@epcas1p3.samsung.com>
 <20180206084251.303-1-philippe.cornu@st.com>
Message-ID: <ec4a4255-38f1-6747-4dc4-09ea9f06126d@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.02.2018 09:42, Philippe Cornu wrote:
> Add support for the Synopsys DesignWare MIPI DSI version 1.31
> Two registers need to be updated/added for supporting 1.31:
> * PHY_TMR_CFG 0x9c (updated)
>   1.30 [31:24] phy_hs2lp_time
>        [23:16] phy_lp2hs_time
>        [14: 0] max_rd_time
>
>   1.31 [25:16] phy_hs2lp_time
>        [ 9: 0] phy_lp2hs_time
>
> * PHY_TMR_RD_CFG 0xf4 (new)
>   1.31 [14: 0] max_rd_time
>
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

If there will be no objections I will merge it this week.

?--
Regards
Andrzej
