From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Thu, 3 Dec 2015 08:30:01 +0800
Subject: [PATCH] clk: rockchip: rk3368: protect aclk_bus and aclk_peri
 clocks
In-Reply-To: <4430667.DaSfi9RHQ7@diego>
References: <1449062551-2498-1-git-send-email-jay.xu@rock-chips.com>
 <4430667.DaSfi9RHQ7@diego>
Message-ID: <565F8D09.4010402@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi heiko

I can see the patches on your clk branch for next
thanks

? 03/12/2015 07:31, Heiko St?bner ??:
> Hi Jianqun,
>
> Am Mittwoch, 2. Dezember 2015, 21:22:31 schrieb jianqun.xu:
>> From: Jianqun xu <jay.xu@rock-chips.com>
>>
>> Add aclk_bus and aclk_peri to the list of rk3368 critical clocks,
>> which are the base clocks that supply for all peripherals, never
>> to be disabled automatically.
>>
>> Signed-off-by: Jianqun xu <jay.xu@rock-chips.com>
>
> applied to my clk branch for 4.5
> [after adapting to Caesar's other critical clock]
>
>
> Thanks
> Heiko
>
>
>

-- 
****************************************************************************
???
Fuzhou Rockchip Electronics Co., Ltd
????????????????89????A?21??
ADDR: No.21 bldg, Fuzhou Software Park,Fuzhou,Fujian,P.R.China
Email: xjq at rock-chips.com
****************************************************************************
???????????????????????????????????? 
??????????????????????????? ???????? 
???????????????????????????????????? 
???????????????????????????????????? 
??????????????????????
IMPORTANT NOTICE: This email is from Fuzhou Rockchip Electronics Co., 
Ltd .The contents of this email and any attachments may contain 
information that is privileged, confidential and/or exempt from 
disclosure under applicable law and relevant NDA. If you are not the 
intended recipient, you are hereby notified that any disclosure, 
copying, distribution, or use of the information is STRICTLY PROHIBITED. 
Please immediately contact the sender as soon as possible and destroy 
the material in its entirety in any format. Thank you.
****************************************************************************
