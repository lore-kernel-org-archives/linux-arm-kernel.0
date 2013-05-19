From: carlo.caione@gmail.com (Carlo Caione)
Date: Sun, 19 May 2013 19:01:54 +0200
Subject: [PATCH v2] ARM: sunxi: New watchdog driver for Allwinner A10/A13
In-Reply-To: <20130519153235.GC7717@lukather>
References: <1368903956-32388-1-git-send-email-carlo.caione@gmail.com>
 <20130519153235.GC7717@lukather>
Message-ID: <F595BD7D-09B6-452A-B8FF-C7B667CE1DF8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On May 19, 2013, at 5:32 PM, Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> Hi Carlo,

Hi Maxime,

>> +
>> +#define WDT_CTRL                0x00
>> +#define WDT_CTRL_RESTART        (1 << 0)
>> +#define WDT_CTRL_RESERVED       (0x0a57 << 1)
> 
> You didn't replied to me on that part in the previous mail. It doesn't
> seem to be needed, so why keeping it?

Actually I wrote you about this on irc (probably you were afk)
Anyway I tested the driver without using the 0x0a57 and without these bits the watchdog is never successfully kicked.
I'm going to submit a v3 soon, addressing also the suggestions given by Henrik on linux-sunxi ml.

Regards,

--
Carlo Caione
