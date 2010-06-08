From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 08 Jun 2010 09:01:35 -0400 (EDT)
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <20100608125053.GD25370@n2100.arm.linux.org.uk>
References: <4C083BCF.2060500@bluewatersys.com>
	<201006040310.15019.marek.vasut@gmail.com>
	<4C0853E1.1080005@bluewatersys.com>
	<AANLkTinEq99_8UyVNnmzNEreDoyHKEnxpuJmaAo_kpPN@mail.gmail.com>
	<20100604061034.GI6499@atomide.com>
	<AANLkTikrK-RkDntgrpptBaG6TvnesNFncOw3DW4Jt-TY@mail.gmail.com>
	<AANLkTil1IetX6koHVRrgnWs3DqhPtZVqR2euEdg9lZUa@mail.gmail.com>
	<alpine.LFD.2.00.1006041418390.22319@xanadu.home>
	<20100608115832.GB25370@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1006080839240.30664@xanadu.home>
	<20100608125053.GD25370@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1006080857390.30664@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Jun 2010, Russell King - ARM Linux wrote:

> On Tue, Jun 08, 2010 at 08:44:52AM -0400, Nicolas Pitre wrote:
> > On Tue, 8 Jun 2010, Russell King - ARM Linux wrote:
> > > I believe the only acceptable solution is to get an alterative method
> > > in place - no matter what it is - and remove the all but one of the
> > > defconfig files from the mainline kernel.  _And_, most importantly,
> > > kautobuild needs to be fixed so that we still get build coverage.
> > 
> > I personally think that your suggestion using STD_CONFIG or similar is a 
> > good way forward.  Specific needs for given targets can then be 
> > expressed along with the Kconfig menu item describing that target.
> 
> It would've been nice, but Linus appears to have ruled that option out too.

I wouldn't give up on that option just yet though.  I don't think he 
fully understood your idea, and without an actual patch it might be hard 
to understand as well, especially for people who are not used to deal 
with the target varieties we have on ARM.  Linus is also known to change 
his mind when presented with evidences.


Nicolas
