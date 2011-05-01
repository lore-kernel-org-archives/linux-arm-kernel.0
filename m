From: richardcochran@gmail.com (Richard Cochran)
Date: Sun, 1 May 2011 08:05:46 +0200
Subject: [PATCH] ARM: Include Makefile.boot only when it exists
In-Reply-To: <20110429133223.GB11885@S2100-06.ap.freescale.net>
References: <1303103976-4922-1-git-send-email-eric.y.miao@gmail.com>
	<20110420083258.GB1517@S2100-06.ap.freescale.net>
	<BANLkTiknesdF7cMZ=RGJAh75aW_wRpyj-w@mail.gmail.com>
	<20110428152735.GU17290@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104281925500.24613@xanadu.home>
	<20110429075346.GU17290@n2100.arm.linux.org.uk>
	<20110429133223.GB11885@S2100-06.ap.freescale.net>
Message-ID: <20110501060546.GA2967@riccoc20.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2011 at 09:32:24PM +0800, Shawn Guo wrote:
> 
> * Maintaining dts file in bootloader tree will get kernel depend on
>   bootloader so heavily.  The kernel code and dts file will easily
>   get out of sync, which may stop kernel booting immediately.

The kernel already depends on the bootloader heavily, at least for
Freescale powerpc boards. If you don't believe me, just try and freely
mix and match kernel/uboot/dts over a few minor versions or so, and
see what happens...

Richard
