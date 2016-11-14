From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 14 Nov 2016 15:51:14 +0000
Subject: [PATCH] ARM: dts: at91: replace gpio-key,wakeup with
 wakeup-source for sam9260ek
In-Reply-To: <55e95acc-d30f-432e-90d6-f96bad69ac3d@atmel.com>
References: <1479138250-17780-2-git-send-email-sudeep.holla@arm.com>
 <55e95acc-d30f-432e-90d6-f96bad69ac3d@atmel.com>
Message-ID: <313991a8-f1e4-4e58-5b36-0dac3c0ad1cd@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 14/11/16 15:45, Nicolas Ferre wrote:
> Le 14/11/2016 ? 16:44, Sudeep Holla a ?crit :
>> Though the keyboard driver for GPIO buttons(gpio-keys) will continue to
>> check for/support the legacy "gpio-key,wakeup" boolean property to
>> enable gpio buttons as wakeup source, "wakeup-source" is the new
>> standard binding.
>>
>> This patch replaces the legacy "gpio-key,wakeup" with the unified
>> "wakeup-source" property in order to avoid any further copy-paste
>> duplication.
>>
>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>
>> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  arch/arm/boot/dts/at91sam9260ek.dts | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> Hi,
>>
>> Inspite of getting rid of most of the legacy property almost a year ago,
>> addition of new platforms have brought this back and over time it's
>> now found again in few places. Just get rid of them *again*
>>
>> Regards,
>> Sudeep
>
> Sorry for this Sudeep and thanks for the patch.
>

No problem, in fact you reminded me to post them :)

-- 
Regards,
Sudeep
