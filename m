From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 22 Mar 2010 14:58:46 -0400 (EDT)
Subject: [RFC 17/18] arm: mm: Add SW emulation for ARM domain manager
	feature
In-Reply-To: <1269281511.31379.53.camel@c-dwalke-linux.qualcomm.com>
References: <1263250057-26692-18-git-send-email-dwalker@codeaurora.org>
	<1264437609.6275.110.camel@pc1117.cambridge.arm.com>
	<1269281511.31379.53.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <alpine.LFD.2.00.1003221457040.31128@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Mar 2010, Daniel Walker wrote:

> On Mon, 2010-01-25 at 16:40 +0000, Catalin Marinas wrote:
> > Hi Daniel,
> > 
> > On Mon, 2010-01-11 at 22:47 +0000, Daniel Walker wrote:
> > > Do not set domain manager bits in cp15 dacr.  Emulate using SW.  Add
> > > kernel hooks to handle domain changes, permission faults, and context
> > > switches.
> > 
> > In case you were not aware, there's a patch around (I think since 2007)
> > that removes the domain switching entirely from the kernel (given that
> > they have been deprecated for some time and may disappear completely in
> > the future):
> > 
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2009-December/005616.html
> > 
> 
> I didn't find this in 2.6.34 ? Are you re-writing it? Why has it been
> around so long out of mainline?

Because no real hardware out there needed it until recently, i.e. 
inertia.


Nicolas
