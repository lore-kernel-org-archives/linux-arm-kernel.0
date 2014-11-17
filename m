From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 17 Nov 2014 21:09:51 +0100
Subject: [PATCH V2 3/5] usb: gadget: pxa25x_udc: prepare/unprepare clocks
 in pxa-ssp
In-Reply-To: <CALT56yMCJ4R6KN2BUW61YaUz2bb6s_aJteKYBSVmvRPKacKCLw@mail.gmail.com>
 (Dmitry Eremin-Solenikov's message of "Tue, 18 Nov 2014 00:05:45
 +0400")
References: <1416236863-20898-1-git-send-email-dbaryshkov@gmail.com>
 <1416236863-20898-3-git-send-email-dbaryshkov@gmail.com>
 <878uj98y5v.fsf@free.fr>
 <CALT56yMCJ4R6KN2BUW61YaUz2bb6s_aJteKYBSVmvRPKacKCLw@mail.gmail.com>
Message-ID: <87y4r97fn4.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

> Hello,
> OK, I will take a look. It seems the correct way would be to strip this code
> away to a phy, like gpio-vbus or nop phys. Do you have access to lubbock
> (or maybe Daniel, Haojian or Russell has?)?
Actually Russell kindly gave me his, so I do have one for testing :)

> Also, as we are at it.  Imre, Krzysztof, IIRC ixp4xx platform does not provide
> clock api either in a form of COMMON_CLK or in a local hacked form
> (like sa1100 does). Do you plan to add any in future, or it just does not
> make sense to support this API for ixp4xx?
I don't have any plans for ixp4xx.

Cheers.

-- 
Robert
