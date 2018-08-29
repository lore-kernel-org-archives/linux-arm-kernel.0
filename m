From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 29 Aug 2018 15:34:10 +0200
Subject: Atmel AT91 support in mainstream kernel 4.4
In-Reply-To: <20180821123047.GB3159@1wt.eu>
References: <CAK3Qp=UAex-68+oCk4v6WOERHiWtB5CEqDtQJvGj+xv2GonOhg@mail.gmail.com>
 <20180821123047.GB3159@1wt.eu>
Message-ID: <20180829133410.GE16561@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 21/08/2018 14:30:47+0200, Willy Tarreau wrote:
> Hi,
> 
> On Tue, Aug 21, 2018 at 02:10:14PM +0200, Fernando AE wrote:
> > Hello all,
> > 
> > I'd like to know if AT91 boards (more specifically AT91SAM9G20) is
> > well supported in mainstream Kernel 4.4.
> > 
> > In more details, I'm working in a project of bringing up Linux 4.4 in
> > a iMX6 based board, while trying to keep the same sources for our
> > legacy AT91 based board. So, I'm wondering if it's a good idea to take
> > Freescale's repo based on 4.4 as reference and compiling both for iMX
> > and AT91.
> 
> FWIW I remember having been running an AT91 board (linuxstamp 2) on
> 2.6.35 with a single patch by then, the one needed to create the board.
> Everything else used to work out of the box. I don't see why anything
> would have regressed since then without anyone complaining loud, so I'd
> be inclined to think it's well supported.
> 

I confirm we don't have any out of tree patch for the at91sam9g20 so you
will get the best support there is using a mainline kernel.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
