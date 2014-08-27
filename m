From: caesar.wang@rock-chips.com (Caesar Wang)
Date: Thu, 28 Aug 2014 04:36:35 +0800
Subject: [PATCH v2 2/2] dt-bindings: document Rockchip thermal
In-Reply-To: <5911166.ElkaNhDZrP@wuerfel>
References: <1409096503-7081-1-git-send-email-caesar.wang@rock-chips.com>
 <1409096503-7081-3-git-send-email-caesar.wang@rock-chips.com>
 <5911166.ElkaNhDZrP@wuerfel>
Message-ID: <53FE4153.3080601@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,


? 2014?08?28? 04:17, Arnd Bergmann ??:
> On Wednesday 27 August 2014 07:41:43 Caesar Wang wrote:
>> +- clock-names : Shall be "tsadc_clk" for the transfer-clock, and "tsadc_pclk" for
>> +    the peripheral clock.
>>
> Why not just name them "clk" and "pclk"? The "tsadc" part seems highly redundant.
>
> Alternatively, how about "transfer" and "peripheral"?

It seems  nappropriate description.

But,I will fix  as the following:

-clock-names ? Shall be "tsadc" for the converter-clock, and "apb_pclk" for
               the peripheral clock.

Thanks!



>
> 	Arnd
>
>
>

-- 
Best regards,
Caesar
