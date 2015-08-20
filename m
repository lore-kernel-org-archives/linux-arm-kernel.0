From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Thu, 20 Aug 2015 16:54:57 -0300
Subject: [PATCH v5 1/2] watchdog: NXP LPC18xx Watchdog Timer Driver
In-Reply-To: <55BD1550.708@roeck-us.net>
References: <1438454237-22043-1-git-send-email-ariel@vanguardiasur.com.ar>
 <1438454237-22043-2-git-send-email-ariel@vanguardiasur.com.ar>
 <55BD1550.708@roeck-us.net>
Message-ID: <CAAEAJfB2aHpaoQpZWCrnhajNjQRCu6zWfFkyZ=Ad9hPnnVx0gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 August 2015 at 15:52, Guenter Roeck <linux@roeck-us.net> wrote:
> On 08/01/2015 11:37 AM, Ariel D'Alessandro wrote:
>>
>> This commit adds support for the watchdog timer found in NXP LPC SoCs
>> family, which includes LPC18xx/LPC43xx. Other SoCs in that family may
>> share the same watchdog hardware.
>>
>> Watchdog driver registers a restart handler that will restart the system
>> by performing an incorrect feed after ensuring the watchdog is enabled in
>> reset mode.
>>
>> As watchdog cannot be disabled in hardware, driver's stop routine will
>> regularly send a keepalive ping using a timer.
>>
>> Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>

Wim,

Any chances you pick this in time for the next merge window?

-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar
