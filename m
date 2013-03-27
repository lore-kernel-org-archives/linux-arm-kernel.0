From: horms@verge.net.au (Simon Horman)
Date: Wed, 27 Mar 2013 21:01:28 +0900
Subject: [PATCH 00/04] ARM: shmobile: r8a73a4 SoC support V3
In-Reply-To: <20130327114553.GA9420@verge.net.au>
References: <20130326013414.11796.9937.sendpatchset@w520>
 <201303261148.56032.arnd@arndb.de>
 <CANqRtoS73UGpq4bv_wkUG9w1AYH9KgSW8Q8Rfjp6Hr080hv6sw@mail.gmail.com>
 <20130327034605.GB25431@verge.net.au>
 <CANqRtoTp-Bx7EVQioekmJZJs5qUCoq=CX6CtukbEHp22RR_goA@mail.gmail.com>
 <20130327114553.GA9420@verge.net.au>
Message-ID: <20130327120127.GL413@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 08:45:54PM +0900, Simon Horman wrote:
> On Wed, Mar 27, 2013 at 05:19:55PM +0900, Magnus Damm wrote:
> > On Wed, Mar 27, 2013 at 12:46 PM, Simon Horman <horms@verge.net.au> wrote:
> > > On Tue, Mar 26, 2013 at 11:17:43PM +0900, Magnus Damm wrote:
> > >> On Tue, Mar 26, 2013 at 8:48 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > >> > On Tuesday 26 March 2013, Magnus Damm wrote:
> > >> >> ARM: shmobile: r8a73a4 SoC support V3
> > >> >> [PATCH 01/04] ARM: shmobile: Initial r8a73a4 SoC support V3
> > >> >> [PATCH 02/04] ARM: shmobile: r8a73a4 SCIF support V3
> > >> >> [PATCH 03/04] ARM: shmobile: r8a73a4 IRQC support V2
> > >> >> [PATCH 04/04] ARM: shmobile: r8a73a4 PFC support
> > >> >>
> > >> >> This series is V3 of initial support for the r8a73a4 SoC. The SoC
> > >> >> is known as r8a73a4 which is built around Cortex-A15 and makes use
> > >> >> of SCIF for serial, IRQC interrupt controller for external IRQs and
> > >> >> PFC for combined support for pinmux and GPIO.
> > >> >>
> > >> >
> > >> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > >>
> > >> Thanks for your help!
> > >
> > > Indeed.
> > >
> > > Magnus, please let me know if/when you would like me to queue-up these
> > > patches.
> > 
> > Thanks. Since you bring up the topic, I'd like you to queue up this
> > patch series more or less right away if possible. =)
> 
> Sure, I think it is possible.

I have applied the series to the soc branch with Arnd's Ack.
