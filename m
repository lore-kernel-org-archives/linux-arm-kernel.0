From: caesar.wang@rock-chips.com (Caesar Wang)
Date: Thu, 06 Nov 2014 21:21:44 +0800
Subject: [PATCH v8 1/3] power-domain: rockchip: add power domain drivers
In-Reply-To: <545B3A18.9030405@rock-chips.com>
References: <1415254961-5746-1-git-send-email-caesar.wang@rock-chips.com>
 <1415254961-5746-2-git-send-email-caesar.wang@rock-chips.com>
 <545B3A18.9030405@rock-chips.com>
Message-ID: <545B75E8.2000903@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


? 2014?11?06? 17:06, Kever Yang ??:
>
> On 11/06/2014 02:22 PM, Caesar Wang wrote:
>> In order to meet high performance and low power requirements, a power
>> management unit is designed or saving power when RK3288 in low power 
>> mode.
>> The RK3288 PMU is dedicated for managing the power ot the whole chip.
>>
>> Signed-off-by: Jack Dai<jack.dai@rock-chips.com>
>> Signed-off-by: jinkun.hong<jinkun.hong@rock-chips.com>
>> Signed-off-by: Caesar Wang<caesar.wang@rock-chips.com>
>>
>> ---
>>
>> Changes in v8:
>>      - This reconciles the v2 and v7 code so that we power domain have
>>      lists of clocks they toggle on and off during power transitions and
>>      independently from power domains clocks we attach clocks to devices
>>      comprising power domain and prepare them so they are turned on 
>> and off
>>      by runtime PM.
> There are more changes like the new rockchip_pm_add_one_domain.

OK.

>>
>> Changes in v7:
>>      - Delete unused variables
>
>
>
>

-- 
Best regards,
Caesar
