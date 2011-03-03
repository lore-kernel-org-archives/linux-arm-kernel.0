From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 Mar 2011 10:20:49 -0800
Subject: [patch v3 3/3] arm: omap4: support pmu
In-Reply-To: <1299149633-699-4-git-send-email-tom.leiming@gmail.com>
References: <1299149633-699-1-git-send-email-tom.leiming@gmail.com>
	<1299149633-699-4-git-send-email-tom.leiming@gmail.com>
Message-ID: <20110303182049.GN20560@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* tom.leiming at gmail.com <tom.leiming@gmail.com> [110303 02:52]:
> From: Ming Lei <tom.leiming@gmail.com>
> 
> This patch supports pmu irq routed from CTI, so
> make pmu/perf working on OMAP4.
> 
> The idea is from Woodruff Richard in the disscussion
> about "Oprofile on Pandaboard / Omap4" on pandaboard at googlegroups.com.
> 
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Woodruff Richard <r-woodruff2@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap at vger.kernel.org
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>

You'll probably want to queue this along with the to other
patches via the Russell, so:

Acked-by: Tony Lindgren <tony@atomide.com>
