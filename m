From: carlo@caione.org (Carlo Caione)
Date: Sat, 20 Sep 2014 18:15:34 +0200
Subject: [PATCH v3 2/4] ARM: meson: add watchdog driver
In-Reply-To: <541D9D94.2010400@roeck-us.net>
References: <1411158989-8075-1-git-send-email-carlo@caione.org>
 <1411158989-8075-3-git-send-email-carlo@caione.org>
 <541D9D94.2010400@roeck-us.net>
Message-ID: <CAOQ7t2a09zB2=qyDfsnJN94Wrj9Zu1c33R1bG5NC2QwzndtmcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 20, 2014 at 5:30 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 09/19/2014 01:36 PM, Carlo Caione wrote:
>>
>> This patch adds the watchdog driver for the Amlogic Meson SoCs used also
>> to reboot the device.
>>
>> Signed-off-by: Carlo Caione <carlo@caione.org>
>> ---
>
> [ ... ]
>>
>> +module_param(nowayout, bool, 0);
>> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
>> +               "(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>> +
>
>
> Checkpatch says:
>
> WARNING: quoted string split across lines
> #295: FILE: drivers/watchdog/meson_wdt.c:231:
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
> +               "(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");

Thought that it was "somehow tolerated" :)
But since I'm wrong I'll submit a v4.

Thanks,

-- 
Carlo Caione
