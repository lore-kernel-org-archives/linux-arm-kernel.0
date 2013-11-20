From: markus.mayer@linaro.org (Markus Mayer)
Date: Wed, 20 Nov 2013 10:42:12 -0800
Subject: [PATCH v4 1/2] watchdog: bcm281xx: Watchdog Driver
In-Reply-To: <20131120184034.GC30952@roeck-us.net>
References: <1384888074-19696-1-git-send-email-markus.mayer@linaro.org>
 <1384888074-19696-2-git-send-email-markus.mayer@linaro.org>
 <CAPdLdqmxFnJ9HZa04buh8NecMszEAp11VRU4Q159vZ+=NG9p3A@mail.gmail.com>
 <20131120162721.GB28683@roeck-us.net>
 <CAPdLdq=xUjsr1ykTHh3t_Uy9kBkKXbW0gpAmtgiOfj8gC42yeA@mail.gmail.com>
 <20131120184034.GC30952@roeck-us.net>
Message-ID: <CAPdLdqma+YMsZqMB3CD=0UEzBPYf3XoCzjkcCMaOOS2mt+51xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 November 2013 10:40, Guenter Roeck <linux@roeck-us.net> wrote:
> On Wed, Nov 20, 2013 at 10:24:54AM -0800, Markus Mayer wrote:
>> > Hi Markus,
>> >
>> > Yes, I noticed when I merged it into my watchdog-next branch.
>> >
>> > Reminds me ... v3 had a whitespace problem. I don't recall if you fixed
>> > that in v4. If you didn't, that might be a better reason to send v5.
>>
>> That's still there, unfortunately. Trailing space on the first
>> help-text line in Kconfig:
>>     Support for the watchdog timer on the following Broadcom BCM281xx
>>
>> So, I'll generate v5 with that fixed. Do you prefer I also rebase it
>> right now to whatever current tip is to take care of the merge
>> conflict?
>>
> I would suggest to wait for -rc1 and rebase to it before you send the new
> version. After all, it won't make it into 3.13 anyway, so no need to hurry.

Sure thing. I'll do that.

Thanks,
-Markus

-- 
Markus Mayer
Broadcom Landing Team
