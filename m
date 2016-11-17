From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 17 Nov 2016 15:32:12 +0000
Subject: [PATCH -next] ARM: dts: omap5: replace gpio-key,wakeup with
 wakeup-source property
In-Reply-To: <20161117152717.GS4082@atomide.com>
References: <1479138250-17780-1-git-send-email-sudeep.holla@arm.com>
 <20161117152717.GS4082@atomide.com>
Message-ID: <8d06724a-98af-05ab-f5a8-07c552722fca@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/11/16 15:27, Tony Lindgren wrote:
> * Sudeep Holla <sudeep.holla@arm.com> [161114 07:44]:
>> Though the keyboard driver for GPIO buttons(gpio-keys) will continue to
>> check for/support the legacy "gpio-key,wakeup" boolean property to
>> enable gpio buttons as wakeup source, "wakeup-source" is the new
>> standard binding.
>>
>> This patch replaces the legacy "gpio-key,wakeup" with the unified
>> "wakeup-source" property in order to avoid any further copy-paste
>> duplication.
>>
>> Cc: "Beno?t Cousson" <bcousson@baylibre.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  arch/arm/boot/dts/omap5-uevm.dts | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Hi,
>>
>> Inspite of getting rid of most of the legacy property almost a year ago,
>> addition of new platforms have brought this back and over time it's
>> now found again in few places. Just get rid of them *again*
>
> Thanks for the annual check up :)
>
> Acked-by: Tony Lindgren <tony@atomide.com>
>
> Please let me know if you want me to pick this up instead.

Yes that would be better. Also it's present only in your -next,
looks like something newly added via commit 2d46c0c60725 ("ARM:
dts: omap5 uevm: add USR1 button")

-- 
Regards,
Sudeep
