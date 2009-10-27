From: avictor.za@gmail.com (Andrew Victor)
Date: Tue, 27 Oct 2009 22:03:00 +0200
Subject: Question: support multiple boards of bcmring SoC?
In-Reply-To: <20091023185900.GI28382@broadcom.com>
References: <20091023185900.GI28382@broadcom.com>
Message-ID: <cd73a99e0910271303l25c6c64bmbff613471871f224@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Leo,

> We have multiple boards using the bcmring SoC, like evm board, sp board,
> and we'd like to submit the support code to the community as well.
> For the code we submitted to arch/arm/mach-bcmring, it supports only one
> board for now.
>
> My question is: what's the standard/best way to support multiple boards for
> one SoC support?

You can possibly have a look at the AT91 processor support
(arch/arm/mach-at91/) for an example.

We have the SoC processor support files (eg, at91rm9200.c and
at91rm9200_devices.c), and a separate file for the various different
boards (eg, board-dk.c, board-eb9200.c, board-kb9202.c).

[The support for the other SoC's in the AT91 family is also in that
directory, so that's why there are other at91*.c and at91*_devices.c
files]

Regards,
  Andrew Victor
