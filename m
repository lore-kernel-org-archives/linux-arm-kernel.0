From: tony@atomide.com (Tony Lindgren)
Date: Fri, 4 Jun 2010 09:10:36 +0300
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <AANLkTinEq99_8UyVNnmzNEreDoyHKEnxpuJmaAo_kpPN@mail.gmail.com>
References: <20100603192459.GA9169@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1006031829020.24526@xanadu.home>
	<4C083BCF.2060500@bluewatersys.com>
	<201006040310.15019.marek.vasut@gmail.com>
	<4C0853E1.1080005@bluewatersys.com>
	<AANLkTinEq99_8UyVNnmzNEreDoyHKEnxpuJmaAo_kpPN@mail.gmail.com>
Message-ID: <20100604061034.GI6499@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Eric Miao <eric.y.miao@gmail.com> [100604 04:35]:
> 
> Also, we are now working on a single kernel for multiple sub-arch (at least
> what Nicolas and I am doing now, and welcome to join us). It's tough (the
> way to handle different phys_offset is only the tip of the iceberg) and seems
> now more and more necessary. so hopefully by the end of the day, we may
> possible end up with only very few defconfig.

Great, do you have some git branch for that somewhere?

Parallel to dealing with different phys_offset we can also try combining
some two ARM platforms that have the same phy_offset. That already exposes
tons of conflicting defines that need to be sorted out..

Regards,

Tony
