From: tony@atomide.com (Tony Lindgren)
Date: Wed, 5 Mar 2014 11:49:43 -0800
Subject: [PATCH 0/4] ARM: dts: OMAP3630+: Add ABB device nodes
In-Reply-To: <20140305194745.GE7599@atomide.com>
References: <1391039177-25284-1-git-send-email-nm@ti.com>
 <20140305194745.GE7599@atomide.com>
Message-ID: <20140305194943.GF7599@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [140305 11:51]:
> * Nishanth Menon <nm@ti.com> [140129 15:48]:
> > Now that clock nodes have been merged to master,
> > refresh of the series meant for all TI platforms using ABB.
> > Originally posted [1], I will restart with v1.
> 
> Thanks applying all except for the crossbar ones into
> omap-for-v3.15/dt.
> 
> Please resend the last three patches once the dependencies
> are merged to mainline kernel as otherwise the interrupt
> nubers are all wrong without the crossbar driver related
> code.

Oops, should have replied this to the pending patches
thread instead, please ignore.

Tony
