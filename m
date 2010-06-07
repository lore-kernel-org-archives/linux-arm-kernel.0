From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 08 Jun 2010 09:09:26 +1200
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <AANLkTil1IetX6koHVRrgnWs3DqhPtZVqR2euEdg9lZUa@mail.gmail.com>
References: <20100603192459.GA9169@n2100.arm.linux.org.uk>	<alpine.LFD.2.00.1006031829020.24526@xanadu.home>	<4C083BCF.2060500@bluewatersys.com>	<201006040310.15019.marek.vasut@gmail.com>	<4C0853E1.1080005@bluewatersys.com>	<AANLkTinEq99_8UyVNnmzNEreDoyHKEnxpuJmaAo_kpPN@mail.gmail.com>	<20100604061034.GI6499@atomide.com>	<AANLkTikrK-RkDntgrpptBaG6TvnesNFncOw3DW4Jt-TY@mail.gmail.com>
	<AANLkTil1IetX6koHVRrgnWs3DqhPtZVqR2euEdg9lZUa@mail.gmail.com>
Message-ID: <4C0D6006.7030700@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Guy wrote:
> Shame. I was about to post a Sim.One defconfig patch (while fully
> realizing that the choice of options is largely arbitrary. and copied
> ad-hoc from some other similar defconfig). While it's nice to be able
> to tell people "make foobar_defconfig; make (z|u|bz)Image" in reality
> the config is as arbitrary as the root filesystem in use (and should
> be chosen to match it).

Once the support runtime phys offset is merged it will be possible for
ep93xx_defconfig to support all of the ep93xx boards.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
