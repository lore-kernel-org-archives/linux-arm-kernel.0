From: ada@thorsis.com (Alexander Dahl)
Date: Wed, 22 Aug 2018 10:15:57 +0200
Subject: Atmel AT91 support in mainstream kernel 4.4
In-Reply-To: <CAK3Qp=UAex-68+oCk4v6WOERHiWtB5CEqDtQJvGj+xv2GonOhg@mail.gmail.com>
References: <CAK3Qp=UAex-68+oCk4v6WOERHiWtB5CEqDtQJvGj+xv2GonOhg@mail.gmail.com>
Message-ID: <2328896.ejRB43oxp2@ada>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hei hei,

Am Dienstag, 21. August 2018, 14:10:14 CEST schrieb Fernando AE:
> I'd like to know if AT91 boards (more specifically AT91SAM9G20) is
> well supported in mainstream Kernel 4.4.

In general from my experience: yes, very well.

In detail: we are using the external memory interface with some SRAM like 
device on an at91sam9g20 based board with special timings and I remember DT 
didn't support that fully until 4.12 IIRC, so depending on your hardware maybe 
you might need some tweaks on the DT side, but that should all be straight 
forward.

Maybe use some newer LTS kernel like 4.9 or 4.14?

> In more details, I'm working in a project of bringing up Linux 4.4 in
> a iMX6 based board, while trying to keep the same sources for our
> legacy AT91 based board. So, I'm wondering if it's a good idea to take
> Freescale's repo based on 4.4 as reference and compiling both for iMX
> and AT91.

AFAIK i.MX6 is also well supported in mainline, so I would also opt for using 
a recent vanilla kernel for both boards.

HTH & Greets
Alex
