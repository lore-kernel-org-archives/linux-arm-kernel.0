From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 19 Aug 2013 08:26:10 -0700
Subject: [Qemu-devel] SCSI bus failures with qemu-arm in kernel 3.8+
In-Reply-To: <CAFEAcA8sOKOs6iQBu7iBdFWW8GymTGR8XSXOceorxzoEoyddNA@mail.gmail.com>
References: <52082EF8.10005@roeck-us.net>
 <CAFEAcA94ygwRPSsfxs3DvOcTZbdafLiEHys94FG4aXUx+A1t=A@mail.gmail.com>
 <20130813034054.GA18218@roeck-us.net>
 <CAFEAcA_-S8z6ZMr8TMPvkcTyyCSMOj1DExVsY4JDQjRXDU5WGw@mail.gmail.com>
 <20130815175428.GA18580@roeck-us.net>
 <CAFEAcA_MyJPwo6Gd_dxeWM5q5-7MYqR6-rrePusFzYaGGckWJQ@mail.gmail.com>
 <20130815205044.GA21599@roeck-us.net>
 <CAFEAcA-ALD+dDWAB+Rd1V+TXQLYGe-qRKC0uFUP0Bt2SGfKDRg@mail.gmail.com>
 <520D53CA.6040807@roeck-us.net>
 <CAFEAcA8sOKOs6iQBu7iBdFWW8GymTGR8XSXOceorxzoEoyddNA@mail.gmail.com>
Message-ID: <20130819152610.GA28431@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 11:23:58PM +0100, Peter Maydell wrote:
> On 15 August 2013 23:18, Guenter Roeck <linux@roeck-us.net> wrote:
> > But doesn't that mean that there is _currently_ no problem ? If so,
> > we can introduce the additional code when the problem really shows up.
> > Being Preemptive is good, but if it is not really needed today
> > I would rather have today's problems resolved and bother about tomorrow's
> > when they show up.
> 
> Conceptually the two parts go together: rely on correct
> irq routing, tell qemu we rely on correct irq routing.
> It's only one extra line...
> 
Possibly, but the lack of progress suggests that by tying both parts
together we might get neither accepted.

Old saying - surgery successful, patient dead.

Guenter
