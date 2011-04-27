From: tony@atomide.com (Tony Lindgren)
Date: Wed, 27 Apr 2011 07:43:35 -0700
Subject: [PATCHv3] ARM:boot:device tree: Allow the device tree binary
	to be appended to zImage
In-Reply-To: <alpine.LFD.2.00.1104271036520.24613@xanadu.home>
References: <20110324231830.2586.7150.stgit@riker>
	<20110328091259.GA18721@S2100-06.ap.freescale.net>
	<20110413140030.GE12665@atomide.com>
	<20110420054746.GA31127@S2100-06.ap.freescale.net>
	<20110420073445.GB31127@S2100-06.ap.freescale.net>
	<20110421080238.GE13688@atomide.com>
	<20110421124618.GA15060@atomide.com>
	<20110427142306.GI3755@atomide.com>
	<alpine.LFD.2.00.1104271036520.24613@xanadu.home>
Message-ID: <20110427144335.GK3755@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [110427 07:37]:
> On Wed, 27 Apr 2011, Tony Lindgren wrote:
> > 
> > I guess the issue is that when setup_machine_fdt gets called we only
> > have minimal MMU mapping done.
> 
> In head.S (the final kernel image one) there is a 1MB mapping 
> established when r2 contains a valid ATAG/DTB pointer.  See commit 
> 4d901c42 (you even ACK'd it).

Yeah thanks was just looking at that too :) Need to debug further..

Tony
