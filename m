From: will.deacon@arm.com (Will Deacon)
Date: Sat, 21 Jul 2012 15:31:22 +0100
Subject: [PATCH v2 05/15] ARM: integrator: use fixed PCI i/o mapping
In-Reply-To: <5005A8A4.6040608@gmail.com>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
 <1342231451-28861-6-git-send-email-robherring2@gmail.com>
 <CACRpkda_to3CzfhvOh-NDx_7Qz+Reg6m1k+uH2stRFy8KSqQmQ@mail.gmail.com>
 <20120717170413.GG14624@mudshark.cambridge.arm.com>
 <5005A8A4.6040608@gmail.com>
Message-ID: <20120721143122.GA26790@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Tue, Jul 17, 2012 at 07:02:12PM +0100, Rob Herring wrote:
> On 07/17/2012 12:04 PM, Will Deacon wrote:
> > On Sat, Jul 14, 2012 at 10:49:47PM +0100, Linus Walleij wrote:
> >> I think the PCI bus on my Integrator/AP is tilted and not suitable
> >> for tests. But IIRC Will Deacon actually has one of these machines
> >> and managed to get ethernet going on it. Maybe he can even test
> >> this patch?
> > 
> > I can try digging out my integrator at the weekend if you like. Are these
> > patches sitting in a branch anywhere that I can grab?
> > 
> 
> git://sources.calxeda.com/kernel/linux.git io-cleanup-pci

I dusted off the integrator, but I'm failing to boot at all if I build from
that branch:

	Uncompressing Linux... done, booting the kernel.
	<silence>

Using the same .config, I can boot v3.5-rc7 just fine (I even rebased your
branch onto that in case something had been fixed in mainline, but it made
no difference).

Will
