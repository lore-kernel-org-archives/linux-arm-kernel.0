From: andrew@ncrmnt.org (Andrew)
Date: Wed, 01 Jul 2015 00:20:14 +0300
Subject: [PATCH v2 5/5] cpuidle: ARM: Add cpuidle driver for K1879XB1YA
In-Reply-To: <3958914.ao1NLj5AqM@wuerfel>
References: <1435677307-6526-1-git-send-email-andrew@ncrmnt.org>
 <1435677307-6526-6-git-send-email-andrew@ncrmnt.org>
 <3958914.ao1NLj5AqM@wuerfel>
Message-ID: <a66090c17d0912e67de833f6461922d5@mail.ncrmnt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann ????? 01.07.2015 00:09:
> On Tuesday 30 June 2015 18:15:07 Andrew Andrianov wrote:
>> +static struct platform_driver rcm_cpuidle_driver = {
>> +       .driver = {
>> +               .name   = "cpuidle-rcm-k1879xb1",
>> +       },
>> +};
>> +
>> 
> 
> Who creates this device?
> 
> 	Arnd

Sorry, you can omit about this cpuidle driver.
We initially planned a second (WFI + DDR self-refresh) state, but
as DDR2 controller enters SR on it's own when needed, so it's only
WFI left here and it doesn't need a special driver.

-- 
Regards,
Andrew
RC Module :: http://module.ru
