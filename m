From: philippe.cornu@st.com (Philippe CORNU)
Date: Thu, 8 Feb 2018 08:35:18 +0000
Subject: [PATCH v2] drm/bridge/synopsys: dsi: Add 1.31 version support
In-Reply-To: <bbe3ffeb-2e93-f36f-a8be-0319e16572e5@samsung.com>
References: <CGME20180206084357epcas1p32e11d1e3c84de7da9d5ba150ded77cdf@epcas1p3.samsung.com>
 <20180206084251.303-1-philippe.cornu@st.com>
 <bbe3ffeb-2e93-f36f-a8be-0319e16572e5@samsung.com>
Message-ID: <c43fbcbc-97f3-82de-4594-86211e930db9@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many thanks
Philippe :-)

On 02/08/2018 08:39 AM, Andrzej Hajda wrote:
> On 06.02.2018 09:42, Philippe Cornu wrote:
>> Add support for the Synopsys DesignWare MIPI DSI version 1.31
>> Two registers need to be updated/added for supporting 1.31:
>> * PHY_TMR_CFG 0x9c (updated)
>>    1.30 [31:24] phy_hs2lp_time
>>         [23:16] phy_lp2hs_time
>>         [14: 0] max_rd_time
>>
>>    1.31 [25:16] phy_hs2lp_time
>>         [ 9: 0] phy_lp2hs_time
>>
>> * PHY_TMR_RD_CFG 0xf4 (new)
>>    1.31 [14: 0] max_rd_time
>>
>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> Queued to drm-misc-next.
> --
> Regards
> Andrzej
> 
