From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 06 Sep 2011 14:30:01 -0400 (EDT)
Subject: [PATCH 2.5/6] ARM: omap: prepare debug-macro.S for offset based
	calculation of omap_uart_phys and virt
In-Reply-To: <20110905094611.GB1903@atomide.com>
References: <1314932353-24813-1-git-send-email-nico@fluxnic.net>
	<1314932353-24813-3-git-send-email-nico@fluxnic.net>
	<20110905094611.GB1903@atomide.com>
Message-ID: <alpine.LFD.2.00.1109061428450.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Sep 2011, Tony Lindgren wrote:

> Just change 99 to 100 to allow using 99 for omap_uart_phys in the
> following patches.

OK I've folded that into 3/6 and 4/6 rather than having a separated 
patch just for this.


Nicolas
