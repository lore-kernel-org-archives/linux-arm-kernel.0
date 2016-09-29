From: richard.genoud@gmail.com (Richard Genoud)
Date: Thu, 29 Sep 2016 08:17:31 +0200
Subject: [PATCH] MAINTAINERS: update entry for atmel_serial driver
In-Reply-To: <1475078653.2685.1.camel@perches.com>
References: <20160928154735.25265-1-nicolas.ferre@atmel.com>
 <1475078653.2685.1.camel@perches.com>
Message-ID: <CACQ1gAiNNWqLmit-G4ch3eVJbBcB-QYa8eupRVqR8aVq6cjf7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-09-28 18:04 GMT+02:00 Joe Perches <joe@perches.com>:
> On Wed, 2016-09-28 at 17:47 +0200, Nicolas Ferre wrote:
>> Change maintainer for the serial driver found on most of the
>> Microchip / Atmel MPUs and take advantage of the move to rename
>> and reorder the entry.
> []
>> diff --git a/MAINTAINERS b/MAINTAINERS
> []
>> +MICROCHIP / ATMEL AT91 / AT32 SERIAL DRIVER
>> +M:   Richard Genoud <richard.genoud@gmail.com>
>> +S:   Maintained
>> +F:   drivers/tty/serial/atmel_serial.c
>> +F:   include/linux/atmel_serial.h
>
> Thanks Richard.
>
> include/linux is pretty cluttered with random files.
>
> atmel_serial.h is #include exactly once.
>
> Please move it out of include/linux and into
> drivers/tty/serial/ one day.
No problem, I'll add that to my TBD list !

Richard.
