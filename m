From: tony@atomide.com (Tony Lindgren)
Date: Wed, 5 Mar 2014 11:47:46 -0800
Subject: [PATCH 0/4] ARM: dts: OMAP3630+: Add ABB device nodes
In-Reply-To: <1391039177-25284-1-git-send-email-nm@ti.com>
References: <1391039177-25284-1-git-send-email-nm@ti.com>
Message-ID: <20140305194745.GE7599@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [140129 15:48]:
> Now that clock nodes have been merged to master,
> refresh of the series meant for all TI platforms using ABB.
> Originally posted [1], I will restart with v1.

Thanks applying all except for the crossbar ones into
omap-for-v3.15/dt.

Please resend the last three patches once the dependencies
are merged to mainline kernel as otherwise the interrupt
nubers are all wrong without the crossbar driver related
code.

Regards,

Tony
