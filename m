From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 01 Nov 2014 10:02:58 -0700
Subject: [PATCH 33/44] avr32: atngw100: Register with kernel poweroff
 handler
In-Reply-To: <20141101101637.GA5765@samfundet.no>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-34-git-send-email-linux@roeck-us.net>
 <20141101101637.GA5765@samfundet.no>
Message-ID: <54551242.2020604@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/2014 03:16 AM, Hans-Christian Egtvedt wrote:
> Around Mon 06 Oct 2014 22:28:35 -0700 or thereabout, Guenter Roeck wrote:
>> Register with kernel poweroff handler instead of setting pm_power_off
>> directly.
>>
>> Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>
>> Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>
> Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>
>

Thanks!

Guenter
