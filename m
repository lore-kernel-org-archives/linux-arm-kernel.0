From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 01 Jan 2016 22:59:37 +0100
Subject: [RFC PATCH] ARM: pxa: add defconfig covering all the boards
In-Reply-To: <22731126.qdCRlGzc5c@wuerfel> (Arnd Bergmann's message of "Thu,
 31 Dec 2015 16:06:52 +0100")
References: <1450630483-28037-1-git-send-email-robert.jarzmik@free.fr>
 <22731126.qdCRlGzc5c@wuerfel>
Message-ID: <87vb7ddkqe.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> Sorry for the late reply. I think this is great and I'd like to just apply it.
> Can you re-send to arm at kernel.org if you're happy with that?
Yep.

> Looking at your description above, I see that you included pxa168_defconfig
> and pxa910_defconfig as well, but they are mach-mmp rather than mach-pxa.
> Can you check if that has added in anything we don't want?
Yep, done.

I added some pxa forgotten sound SoC machine code, I'll send a proper patch once
it passes my testers.

Cheers.

-- 
Robert
