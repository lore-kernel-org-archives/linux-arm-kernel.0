From: david-b@pacbell.net (David Brownell)
Date: Wed, 3 Nov 2010 05:35:54 -0700 (PDT)
Subject: [PATCH v4 08/12] gpio: add ti-ssp gpio driver
In-Reply-To: <AANLkTin=3K0H+YdNM2Nhz63c3+Upp+rwApo-Ww4p5qH6@mail.gmail.com>
Message-ID: <129498.93810.qm@web180302.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



--- On Wed, 11/3/10, Linus Walleij <linus.ml.walleij@gmail.com> wrote:
\
> Date: Wednesday, November 3, 2010, 3:18 AM
> 2010/11/3 David Brownell <david-b@pacbell.net>:
> 
> > That seems like
> > a better structure for various vendors' "SSP"
> > hardware (multifunction serial interface logic)
> 
> Incidentally the ARM PrimeCell PL022 is called SSP,
> "Synchronous Serial Port" and is not multifunction at all.

ISTR coming across that IP module; are you sure
that it only supports a single serial protocol,
instead of just a "small" variety" (multi)?
Unless the hardware only supports one protocol,
my point holds.

I wasn't implying that modules named SSP have
more in common than tending to support
more than a single serial protocol.  If they
only support one, they get names like"USART"
or sometimes CODEC.

- Dave
