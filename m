From: martinwguy@gmail.com (Martin Guy)
Date: Fri, 4 Jun 2010 09:40:45 +0100
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <AANLkTikrK-RkDntgrpptBaG6TvnesNFncOw3DW4Jt-TY@mail.gmail.com>
References: <20100603192459.GA9169@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1006031829020.24526@xanadu.home>
	<4C083BCF.2060500@bluewatersys.com>
	<201006040310.15019.marek.vasut@gmail.com>
	<4C0853E1.1080005@bluewatersys.com>
	<AANLkTinEq99_8UyVNnmzNEreDoyHKEnxpuJmaAo_kpPN@mail.gmail.com>
	<20100604061034.GI6499@atomide.com>
	<AANLkTikrK-RkDntgrpptBaG6TvnesNFncOw3DW4Jt-TY@mail.gmail.com>
Message-ID: <AANLkTil1IetX6koHVRrgnWs3DqhPtZVqR2euEdg9lZUa@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I think you've missed the point.

Linus' problem is that he is spending MOST of his linux-kernel-support
time fielding patches from a dozen port maintainers, and dropping
defconfigs is a desperate attempt to cut the amount of arm fiddling he
is asked to do, and I guess droppiong defconfigs seems to him to be
they way to cut the least important and most verbose part of this
drudgery.
I'm sure he'd rather be writing programs.

While a defconfig restructuring does address the specific issue it's
pointless. He's going to drop defconfigs, so we'll all just have to
have our own web pages giving our suggested defconfigs for our own
boards.

Shame. I was about to post a Sim.One defconfig patch (while fully
realizing that the choice of options is largely arbitrary. and copied
ad-hoc from some other similar defconfig). While it's nice to be able
to tell people "make foobar_defconfig; make (z|u|bz)Image" in reality
the config is as arbitrary as the root filesystem in use (and should
be chosen to match it).

The best way to free up many hours every day of Linus' time is for one
person to isolate him from the port maintainers, so that he only has
to pull (ideally) once per release cycle from one repository.

The question is, do we have the resources and the organization to take
that constant burden of work off one of our brightest programmers so
that he can get on with what he's really interested in?

    M
