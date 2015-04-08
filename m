From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 08 Apr 2015 19:04:59 +0800
Subject: [PATCH v2] ASoC: max98090: add shutdown callback for max98090
In-Reply-To: <55250834.8040208@rock-chips.com>
References: <1428488311-27237-1-git-send-email-wxt@rock-chips.com>
 <55250834.8040208@rock-chips.com>
Message-ID: <55250B5B.4080902@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kever,

? 2015?04?08? 18:51, Kever Yang ??:
> Hi Caesar,
>
> On 04/08/2015 06:18 PM, Caesar Wang wrote:
>> To fix pop noise when shutdown,the pop noise during shutdown
>> is the pmic cutoff power of codec without any notice.
>>
>> Signed-off-by: jay.xu <xjq@rock-chips.com>
>> Signed-off-by: zhengxing <zhengxing@rock-chips.com>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>>
>> Serien-cc: linux-kernel at vger.kernel.org
>> Serien-cc: devicetree at vger.kernel.org
>> Serien-cc: dianders at chromium.org
> Typo? Should be "Series-cc" here I guess.
>

Yeah,it's a mistake from my finger.
I fix it  in v3 patch.

Thanks!
> Thanks,
> - Kever
>
>
>

-- 
**************************************************************************************
???    Caesar Wang
??????   Product R&D Dept.III
??????????? Fuzhou Rockchip Electronics Co.Ltd
????????????????89????A?18?? ??????
         ???????????????21? ???????
Addr?  NO.18 Building, A District, Fuzhou Software Park,Gulou District,Fuzhou, Fujian,China(Fuzhou Headquarters)
          21F,Malata Building,Kejizhongyi Avenue,Nanshan District,Shenzhen  (Shenzhen Office)
Tel?+86-591-83991906/07 - 8221
Mobile:+86 15059456742
E-mail : wxt at rock-chips.com
***************************************************************************************
***************************************************************************************
???????????????????????????????????????????????? ??????????????
??????????????????????????????????????????????????????????????
??????????????????????????
  
IMPORTANT NOTICE: This email is from Fuzhou Rockchip Electronics Co., Ltd .The contents of this email and any attachments may
contain information that is privileged, confidential and/or exempt from disclosure under applicable law and relevant NDA.
If you are not the intended recipient, you are hereby notified that any disclosure, copying, distribution, or use of the
information is STRICTLY PROHIBITED. Please immediately contact the sender as soon as possible and destroy the material
in its entirety in any format. Thank you.
***************************************************************************************
