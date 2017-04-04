From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 4 Apr 2017 15:26:00 -0400 (EDT)
Subject: [PATCH v2 0/5] minitty: a minimal TTY layer alternative for
 embedded systems
In-Reply-To: <1491313228.3704.42.camel@linux.intel.com>
References: <20170401222119.25106-1-nicolas.pitre@linaro.org>
 <CAHp75VdGm2uVPBhfAge4Wx6WW2y52oddpOSfJgdYAfTUQPN7TQ@mail.gmail.com>
 <alpine.LFD.2.20.1704021149550.1847@knanqh.ubzr>
 <1491224186.3704.11.camel@linux.intel.com>
 <alpine.LFD.2.20.1704031121520.1847@knanqh.ubzr>
 <1491242719.3704.33.camel@linux.intel.com>
 <alpine.LFD.2.20.1704031433480.1847@knanqh.ubzr>
 <1491313228.3704.42.camel@linux.intel.com>
Message-ID: <alpine.LFD.2.20.1704041454450.1847@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Apr 2017, Alan Cox wrote:

> > we're down to 5.6K. At which point there's only a raw device
> > interface?
> > to serial hardware.
> 
> Which if you did a simple plain chardev without trying to fake the
> rather out of date uart layer would come down way further still.

Oh absolutely. I don't dispute that. Given infinite time as you said.

But I gained a 5x reduction already. I would prefer moving to some other 
part of the kernel where another 5x reduction could be achieved now 
rather than postponing that after I'm done rewriting the interface for 
all UART drivers.  Maybe someone else will feel inspired and take on 
this UART driver modernizing task (that could be a nice mentorred 
project for example).

PS: FUZIX is a real piece of art  ;-)


Nicolas
