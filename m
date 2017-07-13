From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 13 Jul 2017 22:04:34 +0200
Subject: Porting a custom interrupt handler from kernel 2.6.25 to 3.16.45
In-Reply-To: <CAHumR2LazFFmmNNKJ=KrEjt7iCgrKewkdzO6ww7RtLU+wWTFoA@mail.gmail.com>
References: <CAHumR2+WR3Fdtft8xrPfcT3-dpKqCL__aaEc6qri3N5-x0yCXw@mail.gmail.com>
 <20170713160625.GB27801@lunn.ch>
 <CAHumR2LazFFmmNNKJ=KrEjt7iCgrKewkdzO6ww7RtLU+wWTFoA@mail.gmail.com>
Message-ID: <20170713200434.GE3120@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 06:32:29PM +0200, Mircea Ciocan wrote:
> On Thu, Jul 13, 2017 at 6:06 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> > On Thu, Jul 13, 2017 at 10:23:41AM +0200, Mircea Ciocan wrote:
> >> Hello everybody, I'm new to the intricacies of the ARM platform
> >> interrupt handling and I have to port a custom interrupt handler from
> >> 2.6.25 to 3.16.45.
> >
> > Hi Mircea
> >
> > Could you please take a step back and explain why you need a custom
> > interrupt handler.
> >
> >           Andrew
> 
> Hi Andrew, sure I can explain, or at least offer the original
> explanation of the long lost developer:
> The ARM core has a custom interrupt controller and a DSP co-processor
> that does some funny (read strange & abnormal) stuff.

Hi Mircea

How is this interrupt controller connected? Is it chained off another
interrupt controller? Or is it a root interrupt controller?

	  Andrew
