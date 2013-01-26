From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 26 Jan 2013 16:33:57 +0100
Subject: [PATCH V3 8/8] ARM: kirkwood: mv643xx_eth dt conversion
In-Reply-To: <a4805edf01c39a374d71fbf4a6b6207dedf6b2bf.1359146831.git.jason@lakedaemon.net>
References: <cover.1359146831.git.jason@lakedaemon.net>
 <a4805edf01c39a374d71fbf4a6b6207dedf6b2bf.1359146831.git.jason@lakedaemon.net>
Message-ID: <20130126153357.GG29973@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -config MACH_LSXL_DT
> -	bool "Buffalo Linkstation LS-XHL, LS-CHLv2 (Flattened Device Tree)"
> -	select ARCH_KIRKWOOD_DT
> -	select POWER_RESET_RESTART
> -	help
> -	  Say 'Y' here if you want your kernel to support the
> -	  Buffalo Linkstation LS-XHL & LS-CHLv2 devices, using
> -	  Flattened Device Tree.

Hi Jason

I don't think you add POWER_RESET_RESTART back anywhere. It should
probably be added to ARCH_KIRKWOOD_DT. Otherwise it will not be
possible to shutdown these boxes.

	 Thanks
		Andrew
