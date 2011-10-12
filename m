From: cavokz@gmail.com (Domenico Andreoli)
Date: Wed, 12 Oct 2011 16:28:36 +0200
Subject: [PATCH] Add platform driver support to the CS890x driver
In-Reply-To: <20111001171340.GN11710@n2100.arm.linux.org.uk>
References: <1315390967-6683-1-git-send-email-jaccon.bastiaansen@gmail.com>
	<20110907125047.GU28816@pengutronix.de>
	<CAGzjT4f3VDL-rDzup4kSc11eCdhR9s7fxf8RYNjEZmK9Rk50Cw@mail.gmail.com>
	<20110910141244.GQ28816@pengutronix.de>
	<CAGzjT4f2agA30TGb8XFSRu57=--qyBt=bU5QWVTmU6LAGmwM8A@mail.gmail.com>
	<20110911185312.GD28624@pengutronix.de>
	<CAGzjT4ce0gZ2e6cM1PfUb9JkZ=52PUCjPz1C9qjjRYxgSJckbQ@mail.gmail.com>
	<20110928083048.GA15311@glitch.intra.local>
	<CAGzjT4fkjs7j=a0P=EcPcx-KJpZsMy=cmpYd2STO3Mk8yhoT_Q@mail.gmail.com>
	<20111001171340.GN11710@n2100.arm.linux.org.uk>
Message-ID: <20111012142836.GA461@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 01, 2011 at 06:13:40PM +0100, Russell King - ARM Linux wrote:
> On Fri, Sep 30, 2011 at 11:01:10AM +0200, Jaccon Bastiaansen wrote:
> > Hello Domenico,
> > 
> > 2011/9/28 Domenico Andreoli <cavokz@gmail.com>:
> > > Hi Jaccon,
> > >
> > > On Mon, Sep 12, 2011 at 12:52:52PM +0200, Jaccon Bastiaansen wrote:
> > >>
> > >> Ok, so you would like to see the #ifdefs for the IXDP2351, IXDP2X01,
> > >> QQ2440 and MX31ADS in the cs890x driver replaced by platform_device
> > >> definitions in the platform specific code of those platforms (in the
> > >> same way as I have done for the i.MX21ADS platform)? Is this correct?
> > >
> > > Feel free to completely dump the QQ2440 thing, the QQ2440 board support
> > > is not in mainline and will not until it can be implemented mostly with
> > > DT, I guess. ?At that time I will be happy to use your platform device
> > > conversion - with the OF initialization that sombody will write ;)
> 
> I don't have Domenico's original mail...

yes, there was a problem on my side that I hope is now fixed.

> It's now up to the SoC maintainers whether they want to accept this stuff,
> and if so how to get it into mainline (probably via Arnd) - be that in
> their current form or if they think that a DT based implementation is
> better.
> 
> I'll be discarding the four 'new' platforms (of which QQ2440 is one) which
> have been sitting in the patch system since March in the next few days.

thank you.

Regards,
Domenico
