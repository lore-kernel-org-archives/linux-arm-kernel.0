From: david.wu@rock-chips.com (David.Wu)
Date: Mon, 21 Aug 2017 19:15:18 +0800
Subject: [PATCH v2 1/4] clk: rockchip: add rv1108 ACLK_GAMC and PCLK_GMAC
 ID
In-Reply-To: <19279521.prAVXYBsZ9@phil>
References: <1503303367-17915-1-git-send-email-zhangqing@rock-chips.com>
 <1503303367-17915-2-git-send-email-zhangqing@rock-chips.com>
 <f51160d5-32cc-a63c-3877-76ea91fb6e8b@rock-chips.com>
 <19279521.prAVXYBsZ9@phil>
Message-ID: <4765221b-e122-b67d-cec2-dffbeeadc379@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

? 2017/8/21 18:32, Heiko Stuebner ??:
> Hi David,
> 
> Am Montag, 21. August 2017, 18:22:31 CEST schrieb David.Wu:
>> Hi Elaine,
>>
>> ? 2017/8/21 16:16, Elaine Zhang ??:
>>> This patch exports gmac aclk and pclk for dts reference.
>>>
>>> Signed-off-by: Elaine Zhang<zhangqing@rock-chips.com>
>>> ---
>>>    include/dt-bindings/clock/rv1108-cru.h | 2 ++
>>>    1 file changed, 2 insertions(+)
>>
>> Acked-by: David Wu <david.wu@rock-chips.com>
> 
> Acked-by is mainly meant for cross-maintainer stuff (changes
> for one subsystem going through a different tree etc).
> 
> If you want to show that the change is correct and you have reviewed
> the patch, please use "Reviewed-by".
> 

Yeap, my intent is that the patches are correct. And change the tag here.?
So for the series:

Reviewed-by: David Wu <david.wu@rock-chips.com>

> 
> Heiko
> 
> 
> 
