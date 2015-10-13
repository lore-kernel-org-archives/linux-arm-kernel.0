From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 13 Oct 2015 22:08:19 +0200
Subject: [PATCH v4 02/26] ARM: pxa: magician: Change comments to be more
 informative
In-Reply-To: <1443874764.4186.8.camel@gmail.com> (Philipp Zabel's message of
 "Sat, 03 Oct 2015 14:19:24 +0200")
References: <cover.1443472089.git.petr.cvek@tul.cz> <5609ACBA.6080503@tul.cz>
 <1443874764.4186.8.camel@gmail.com>
Message-ID: <87si5e4jm4.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Philipp Zabel <philipp.zabel@gmail.com> writes:

> Am Montag, den 28.09.2015, 23:10 +0200 schrieb Petr Cvek:
>> This patch changes the comments in the HTC Magician machine source
>> code
>> to better describe used devices and interfaces.
>> 
>> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
Queued to pxa/for-next with Philipp's comments taken into account.

Thanks.

--
Robert

PS: the MP1521 topic
>> +/*
>> + * LCD PWM backlight (main)
>> + *
>> + * MP1521 frequency should be:
>> + *	100-400 Hz = 2?.5*10^6 - 10?*10^6 ns
>
> What is MP1521?
How about this one :
http://www.digchip.com/datasheets/parts/datasheet/1006/MP1521-pdf.php
