From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sat, 05 Jun 2010 00:08:44 +0200
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <alpine.LFD.2.00.1006041418390.22319@xanadu.home> (Nicolas
	Pitre's message of "Fri, 04 Jun 2010 16:51:24 -0400 (EDT)")
References: <20100603192459.GA9169@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1006031829020.24526@xanadu.home>
	<4C083BCF.2060500@bluewatersys.com>
	<201006040310.15019.marek.vasut@gmail.com>
	<4C0853E1.1080005@bluewatersys.com>
	<AANLkTinEq99_8UyVNnmzNEreDoyHKEnxpuJmaAo_kpPN@mail.gmail.com>
	<20100604061034.GI6499@atomide.com>
	<AANLkTikrK-RkDntgrpptBaG6TvnesNFncOw3DW4Jt-TY@mail.gmail.com>
	<AANLkTil1IetX6koHVRrgnWs3DqhPtZVqR2euEdg9lZUa@mail.gmail.com>
	<alpine.LFD.2.00.1006041418390.22319@xanadu.home>
Message-ID: <m38w6ulac3.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre <nico@fluxnic.net> writes:

> Linus wants something to be done about the current defconfig mess which 
> is perfectly legitimate.  He even suggested a possible solution.  I 
> don't think he'll simply drop those defconfig files if we demonstrate 
> that we're taking action to fix the actual problem.

To be honest, I see no usefulness in current defconfigs. Not only ARM
- in any and all defconfigs altogether.

Having this info somewhere on the web, maybe - just like we have the
build logs etc. But in the kernel source tree?

I wonder if I'm the only one frequently doing
grep CONFIG* ... | grep -v defconfig.

I think the issue will fix itself when the "select problem" is fixed.
And we should've fixed the "select problem" long ago (e.g. Kconfig*
should be able to select things without worrying about intermediate
steps, and it should be able to ask the user if needed).
-- 
Krzysztof Halasa
