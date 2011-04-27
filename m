From: tony@atomide.com (Tony Lindgren)
Date: Wed, 27 Apr 2011 07:38:45 -0700
Subject: [PATCHv3] ARM:boot:device tree: Allow the device tree binary
	to be appended to zImage
In-Reply-To: <20110427142306.GI3755@atomide.com>
References: <20110324231830.2586.7150.stgit@riker>
	<20110328091259.GA18721@S2100-06.ap.freescale.net>
	<20110413140030.GE12665@atomide.com>
	<20110420054746.GA31127@S2100-06.ap.freescale.net>
	<20110420073445.GB31127@S2100-06.ap.freescale.net>
	<20110421080238.GE13688@atomide.com>
	<20110421124618.GA15060@atomide.com>
	<20110427142306.GI3755@atomide.com>
Message-ID: <20110427143845.GJ3755@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [110427 07:20]:
> 
> I guess the issue is that when setup_machine_fdt gets called we only
> have minimal MMU mapping done.
> 
> So I guess there's some other patch related to it?

Hmm head.S should already map the boot params address in r2..
Looks like more debugging is needed.

Tony
