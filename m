From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 19 Oct 2014 21:19:49 +0200
Subject: [PATCH] Revert "ARM: pxa: call debug_ll_io_init for earlyprintk"
In-Reply-To: <20141013221728.GB1550@og3k> (Andrew Ruder's message of "Mon, 13
 Oct 2014 17:17:28 -0500")
References: <1412602320-22896-1-git-send-email-dbaryshkov@gmail.com>
 <7809732.cy12qq1fce@wuerfel> <87siizad3v.fsf@free.fr>
 <2827244.zVyLBe8KIg@wuerfel> <87wq858l4q.fsf@free.fr>
 <20141013221728.GB1550@og3k>
Message-ID: <874muz3m0a.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew Ruder <andrew.ruder@elecsyscorp.com> writes:

> On Sun, Oct 12, 2014 at 03:37:09PM +0200, Robert Jarzmik wrote:
>> A small test would be welcome, as I don't have a pxa25x board, and my board
>> doesn't have an available UART for debugging anyway.
>
> I should be able to give it a test on a pxa270 board in the next 24
> hours or so but I don't have any pxa25x boards to test with.

Queued to pxa/fixes.

Cheers.

-- 
Robert
