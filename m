From: zhengxing@rock-chips.com (Xing Zheng)
Date: Tue, 29 Mar 2016 09:17:04 +0800
Subject: [PATCH v6 0/3] Add more clock compatible features and support the
 RK3399 clock
In-Reply-To: <4649399.g7v7zsVJik@diego>
References: <1459158697-8218-1-git-send-email-zhengxing@rock-chips.com>
 <4649399.g7v7zsVJik@diego>
Message-ID: <56F9D790.1080608@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2016?03?28? 20:59, Heiko St?bner wrote:
> Am Montag, 28. M?rz 2016, 17:51:34 schrieb Xing Zheng:
>>    The patch series add support more mux parameters and multiple
>> clock providers for the rockchip features of the clock framework,
>> and support the clock controller for the RK3399.
> applied all 3 for 4.7 with one change:
>
> I've dropped the grf paragraph from the binding doc (as it is not used
> anymore) and also dropped the gmac_phy_rx_clk input clock.
>
> We can add these back once they are getting used in the future.
>
>
> Heiko
>
OK, thanks Heiko. :-)

-- 
- Xing Zheng
