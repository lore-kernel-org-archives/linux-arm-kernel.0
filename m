From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Feb 2011 08:24:21 -0800
Subject: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
In-Reply-To: <80a27c86473cf29a9fa5e68aa29eef46@mail.gmail.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<0557426516de482c1769a50fa0b5f17a@mail.gmail.com>
	<20110208164747.GD6188@n2100.arm.linux.org.uk>
	<78d0134576ace6be5874871076cf0c10@mail.gmail.com>
	<alpine.LFD.2.00.1102081537010.14920@xanadu.home>
	<20110209003537.GQ20795@atomide.com>
	<54f225541194205f01fe9f03b5110d16@mail.gmail.com>
	<AANLkTin2zB32YVPZkr48gSOjm0N-WDnZFScysKC8ZTiv@mail.gmail.com>
	<80a27c86473cf29a9fa5e68aa29eef46@mail.gmail.com>
Message-ID: <20110209162421.GU20795@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110209 01:59]:
> > From: Dave Martin [mailto:dave.martin at linaro.org]
> >
> > You could also have a "v7+" unified kernel -- i.e., supporting
> > OMAP3+4+SMP.
> > This is what we currently do in Linaro, since we're focusing on v7
> > and above.
> >
> This sounds good way forward considering future OMAP architectures
> as well.
> 
> But I let Tony comment on this idea.

AFAIK these issues will be hopefully sorted out by the time the
next merge window opens. For the -rc cycle, disabling SMP in
config if ARMv6 is selected should do the trick.

Regards,

Tony
