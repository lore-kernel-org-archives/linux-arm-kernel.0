From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 16 Jan 2018 11:43:50 +0530
Subject: [PATCH net-next v5 1/4] phy: add 2.5G SGMII mode to the phy_mode
 enum
In-Reply-To: <20180115.142101.1289745159491091124.davem@davemloft.net>
References: <20180112075130.30890-1-antoine.tenart@free-electrons.com>
 <20180112075130.30890-2-antoine.tenart@free-electrons.com>
 <20180115.142101.1289745159491091124.davem@davemloft.net>
Message-ID: <2fc11f35-885a-af38-3949-e2c8702e51dc@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 16 January 2018 12:51 AM, David Miller wrote:
> From: Antoine Tenart <antoine.tenart@free-electrons.com>
> Date: Fri, 12 Jan 2018 08:51:27 +0100
> 
>> This patch adds one more generic PHY mode to the phy_mode enum, to allow
>> configuring generic PHYs to the 2.5G SGMII mode by using the set_mode
>> callback.
>>
>> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> PHY layer folks, and reviews please?
> 
>> ---
>>  include/linux/phy/phy.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
>> index 4f8423a948d5..5a80e9de3686 100644
>> --- a/include/linux/phy/phy.h
>> +++ b/include/linux/phy/phy.h
>> @@ -28,6 +28,7 @@ enum phy_mode {
>>  	PHY_MODE_USB_DEVICE,
>>  	PHY_MODE_USB_OTG,
>>  	PHY_MODE_SGMII,
>> +	PHY_MODE_2500SGMII,
>>  	PHY_MODE_10GKR,
>>  	PHY_MODE_UFS_HS_A,
>>  	PHY_MODE_UFS_HS_B,
>> -- 
>> 2.14.3
>>
