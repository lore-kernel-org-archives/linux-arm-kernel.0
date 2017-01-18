From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 18 Jan 2017 19:21:04 +0100
Subject: [PATCH] ARM: pxa: include linux/leds.h
In-Reply-To: <20170118164936.3832865-1-arnd@arndb.de> (Arnd Bergmann's message
 of "Wed, 18 Jan 2017 17:49:24 +0100")
References: <20170118164936.3832865-1-arnd@arndb.de>
Message-ID: <87mveodyb3.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> When the header is not included implicitly, we get a build failure:
>
> arch/arm/mach-pxa/idp.c:205:22: error: field 'cdev' has incomplete type
>   struct led_classdev     cdev;
>
> This adds an explicit #include.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Sure, pushed into pxa/for-next, I hope it's not troublesome enough to include it
in the 4.10 cycle pxa fixes which is ... empty so far.

Cheers.

--
Robert
