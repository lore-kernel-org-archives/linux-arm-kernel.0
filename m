From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 02 Nov 2009 18:14:13 +0100
Subject: [PATCH] pxa: fix system resume issue on pxa27x and pxa3xx
In-Reply-To: <771cded00911020342j5266b3c4ga4e94324c2369630@mail.gmail.com>
	(Haojian Zhuang's message of "Mon\, 2 Nov 2009 07\:42\:14 -0400")
References: <771cded00911020342j5266b3c4ga4e94324c2369630@mail.gmail.com>
Message-ID: <87ws28aly2.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang <haojian.zhuang@gmail.com> writes:

> From 1764e836424d42a0654b8b73c402a2dddb118dc4 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Mon, 2 Nov 2009 14:02:21 -0500
> Subject: [PATCH] pxa: fix system resume issue on pxa27x and pxa3xx
>
> Since interrupt handler is changed to use interrupt priority, we also need to
> save and restore these interrupt controller registers in suspend/resume
> routine.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> Tested-by: Daniel Mack <daniel@caiaq.de>

Yes, the fix does work for my platform too, well done.
Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>

As a side note, the "128" magic number may have deserved a little define
somewhere.

Cheers.

--
Robert
