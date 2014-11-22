From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 22 Nov 2014 14:56:13 +0100
Subject: [PATCH V2 3/5] usb: gadget: pxa25x_udc: prepare/unprepare clocks
 in pxa-ssp
In-Reply-To: <87egsz6ija.fsf@free.fr> (Robert Jarzmik's message of "Wed, 19
 Nov 2014 21:29:29 +0100")
References: <1416236863-20898-1-git-send-email-dbaryshkov@gmail.com>
 <1416236863-20898-3-git-send-email-dbaryshkov@gmail.com>
 <878uj98y5v.fsf@free.fr>
 <CALT56yMCJ4R6KN2BUW61YaUz2bb6s_aJteKYBSVmvRPKacKCLw@mail.gmail.com>
 <CALT56yO8tktrXo0rfRd91AtXBE4F5vYfYjm9AL+7dcoam6Oq9Q@mail.gmail.com>
 <87egsz6ija.fsf@free.fr>
Message-ID: <87sihb49vm.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:
> Okay, now my ADSL line is repaired, thank you Mr farmer "I drive a tractor but I
> don't care about telephone posts", I'll fetch your changes and make a
> test. Let's say I schedule this for saturday.

Removed people from the list for the tests aspect.

Well, my lubbock board seem to raise several interrupts in the linux kernel, all
the LUBBOCK_IRQ interrupts multiplexed on GPIO0 actually, amongst which are the
2 interrupts for the UDC.

That will mean delay I'm afraid, as I have to find out what happens. I'm pretty
sure the hardware is OK, because the "blob" loader uses the ethernet card which
is amongst the LUBBOCK_IRQs.

There is probably a regression in the kernel not seen for several revisions, and
I have to fix it before I can test.

Cheers.

-- 
Robert
