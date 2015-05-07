From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 07 May 2015 23:03:00 +0200
Subject: [GIT PULL] pxa fixes for v4.1
In-Reply-To: <201505071823.30533.arnd@arndb.de> (Arnd Bergmann's message of
 "Thu, 7 May 2015 18:23:30 +0200")
References: <87r3r0jzge.fsf@belgarion.home> <201505071823.30533.arnd@arndb.de>
Message-ID: <877fskumm3.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

>> These fixes reenable the lubbock(pxa25x) and mainstone(pxa27x)
>> platforms, which were broken since the gpio handling was
>> converted to a driver, and the interrupt ordering broke the
>> external interrupts of these systems.
>
> Pulled into fixes branch, thanks!
>
> 	Arnd
Thanks Arnd.

Cheers.

-- 
Robert
