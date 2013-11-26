From: tony@atomide.com (Tony Lindgren)
Date: Tue, 26 Nov 2013 08:25:03 -0800
Subject: [PATCH 00/12] Drop omap3 board files and make mach-omap2 boot
 in DT only mode
In-Reply-To: <20131126142530.GA32406@earth.universe>
References: <1385424867-27243-1-git-send-email-tony@atomide.com>
 <52949790.1010900@epfl.ch> <20131126142530.GA32406@earth.universe>
Message-ID: <20131126162502.GD26766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sebastian Reichel <sre@debian.org> [131126 06:26]:
> Hi,
> 
> On Tue, Nov 26, 2013 at 01:44:00PM +0100, Florian Vaussard wrote:
> > IMHO one remaining issue is the missing binding for the camera interface
> > (ISP). I saw recently an RFC from Sebastian Reichel to add the necessary
> > binding [1], but this work will probably take some time. So probably a
> > quirk is necessary here to bring up this IP.
> 
> My DT patches for omap3-isp won't be ready for 3.14.

No problem, we can init omap3-isp with auxdata from pdata-quirks.c
meanwhile.

Regards,

Tony
