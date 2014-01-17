From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 17 Jan 2014 11:58:52 -0500 (EST)
Subject: How to support SDIO wifi/bt in DT
In-Reply-To: <CAL_JsqKX2RT2E6uk3d35m+TWW7iuPFFiuZzOwd0xA9zMgqAZRw@mail.gmail.com>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
 <3215037.8HVCjAeS8g@wuerfel>
 <CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com>
 <alpine.LFD.2.10.1401162204560.28907@knanqh.ubzr>
 <CAL_JsqKX2RT2E6uk3d35m+TWW7iuPFFiuZzOwd0xA9zMgqAZRw@mail.gmail.com>
Message-ID: <alpine.LFD.2.10.1401171157340.28907@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 Jan 2014, Rob Herring wrote:

> On Thu, Jan 16, 2014 at 9:08 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Thu, 16 Jan 2014, Olof Johansson wrote:
> >
> >> "for SDIO slots" is somewhat misleading; nearly all controllers only
> >> do one slot/device per controller. The designware controller can do
> >> multiple slots, and that adds a bit of driver and binding complexity
> >> for something that seemingly not a single vendor has actually
> >> implemented.
> >
> > The Marvell 8688, just to name one, does both WIFI and BlueTooth over
> > the same SDIO controller using separate functions/slots.
> 
> But that is logical functions within a chip, not multiple discrete
> chips (i.e. slots) with their own reset, regulators, etc.

OK.  If that's the definition of a slot in this context then I agree.


Nicolas
