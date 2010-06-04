From: pieterg@gmx.com (pieterg)
Date: Fri, 4 Jun 2010 10:36:39 +0200
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <201006040310.15019.marek.vasut@gmail.com>
References: <20100603192459.GA9169@n2100.arm.linux.org.uk>
	<4C083BCF.2060500@bluewatersys.com>
	<201006040310.15019.marek.vasut@gmail.com>
Message-ID: <201006041036.39059.pieterg@gmx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 June 2010 03:10:14 Marek Vasut wrote:
> I just tested, PXA (mach-pxa) probably can be compiled into single kernel
> supporting all the boards.

For my boards (colibri) I see only one exception; I haven't managed to build 
a single kernel with support for different AC97 chips.

I have to build separate WM9715 and UCB1400 kernels.

Rgds, Pieter
