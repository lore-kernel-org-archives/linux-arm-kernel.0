From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 26 Jan 2013 10:44:16 -0500
Subject: [PATCH V3 8/8] ARM: kirkwood: mv643xx_eth dt conversion
In-Reply-To: <20130126153357.GG29973@lunn.ch>
References: <cover.1359146831.git.jason@lakedaemon.net>
 <a4805edf01c39a374d71fbf4a6b6207dedf6b2bf.1359146831.git.jason@lakedaemon.net>
 <20130126153357.GG29973@lunn.ch>
Message-ID: <20130126154416.GN1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 26, 2013 at 04:33:57PM +0100, Andrew Lunn wrote:
> > -config MACH_LSXL_DT
> > -	bool "Buffalo Linkstation LS-XHL, LS-CHLv2 (Flattened Device Tree)"
> > -	select ARCH_KIRKWOOD_DT
> > -	select POWER_RESET_RESTART
> > -	help
> > -	  Say 'Y' here if you want your kernel to support the
> > -	  Buffalo Linkstation LS-XHL & LS-CHLv2 devices, using
> > -	  Flattened Device Tree.
> 
> Hi Jason
> 
> I don't think you add POWER_RESET_RESTART back anywhere. It should
> probably be added to ARCH_KIRKWOOD_DT. Otherwise it will not be
> possible to shutdown these boxes.

Good catch, I'll add that in.

thx,

Jason.
