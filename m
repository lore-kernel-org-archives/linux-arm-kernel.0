From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 29 Aug 2016 22:01:46 +0200
Subject: [PATCH] ARM: pxa: remove irq init from dt machines
In-Reply-To: <2040480.LI9qyCOOTW@wuerfel> (Arnd Bergmann's message of "Tue, 23
 Aug 2016 14:50:18 +0200")
References: <1471213495-2315-1-git-send-email-robert.jarzmik@free.fr>
 <2040480.LI9qyCOOTW@wuerfel>
Message-ID: <871t17e445.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Monday, August 15, 2016 12:24:55 AM CEST Robert Jarzmik wrote:
>> The init_irq and handle_irq can be declared through standard irqchip
>> declaration and are not necessary in machine descriptions.
>> 
>> This is another step towards the generic kernel for the pxa
>> architecture.
>> 
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> 
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
Thanks Arnd, queued to pxa/for-next.

Cheers.

-- 
Robert
