From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 12 Oct 2014 15:37:09 +0200
Subject: [PATCH] Revert "ARM: pxa: call debug_ll_io_init for earlyprintk"
In-Reply-To: <2827244.zVyLBe8KIg@wuerfel> (Arnd Bergmann's message of "Tue, 07
 Oct 2014 23:36:47 +0200")
References: <1412602320-22896-1-git-send-email-dbaryshkov@gmail.com>
 <7809732.cy12qq1fce@wuerfel> <87siizad3v.fsf@free.fr>
 <2827244.zVyLBe8KIg@wuerfel>
Message-ID: <87wq858l4q.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> Ah, you mean doing it now? That would work too.
>
> I was thinking of reverting the patch for now and fixing it properly later,
> but your patch also looks simple enough that we could probably just do it.
>
...zip...
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Andrew, Dmitry,

A small test would be welcome, as I don't have a pxa25x board, and my board
doesn't have an available UART for debugging anyway.

If I have no news in the next week I'll consider it fixes the problem, and we'll
move forward.

Cheers.

--
Robert
