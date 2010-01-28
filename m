From: kevin.wells@nxp.com (Kevin Wells)
Date: Thu, 28 Jan 2010 20:58:45 +0100
Subject: LPC32XX architecture files (updated)
In-Reply-To: <20100128190644.GA7765@pengutronix.de>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
	<20100128190644.GA7765@pengutronix.de>
Message-ID: <083DF309106F364B939360100EC290F805C8A0A7FB@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi,
> 
> as I read it, the order of the patches could be improved. For example,
> patches
> 1-3 check for ARCH_LPC32XX which is only introduced in Patch 4 (which then
> includes the Kconfig from the subdir which again is introduced in #5).
> This makes bisecting troublesome.
> 

I see what you mean with git bisect. Once I get some of the other review
comments installed, I'll release a (hopeful) final round of patches with
a better organized patch order...
