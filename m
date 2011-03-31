From: sam@ravnborg.org (Sam Ravnborg)
Date: Thu, 31 Mar 2011 20:12:54 +0200
Subject: [GIT PULL] omap changes for v2.6.39 merge window
In-Reply-To: <20110331130123.GB17547@n2100.arm.linux.org.uk>
References: <AANLkTim6zg-U6HtAQbqnENqoK7x8erXSqOuTFVC0YE5r@mail.gmail.com>
	<alpine.LFD.2.00.1103301814250.28032@xanadu.home>
	<alpine.DEB.2.00.1103301728000.15330@asgard.lang.hm>
	<alpine.LFD.2.00.1103302255280.28032@xanadu.home>
	<AANLkTikV5OMifKjWRVdtJLEcxcZ56jrjWLYJBX89pHQ0@mail.gmail.com>
	<alpine.LFD.2.00.1103310012500.28032@xanadu.home>
	<20110331105440.42692165@lxorguk.ukuu.org.uk>
	<20110331105000.GC14323@n2100.arm.linux.org.uk>
	<1301575101.10659.132.camel@e102109-lin.cambridge.arm.com>
	<20110331130123.GB17547@n2100.arm.linux.org.uk>
Message-ID: <20110331181254.GA21981@merkur.ravnborg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> And since Linus' whinge about ARM defconfigs, I really *hate* merging
> anything with *any* defconfig changes in - as a result, I don't
> particularly want to deal with ARM defconfig changes anymore.

I thought we solved this with the introduction of "make savedefconfig"
that created much much smaller defconfig.
At least the defconfigs should be down in the noise level in the
diffstats.

We can always argue about the usefullness of the 100+ defconfigs,
that is still unreadable.
But at least they no longer dominate the diffs (if people remember
to use "make savedefconfig".

	Sam
