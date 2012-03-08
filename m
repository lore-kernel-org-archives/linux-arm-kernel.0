From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Mar 2012 13:12:48 -0800
Subject: [PATCH v2 1/3] ARM: OMAP2+: McBSP: Correct CLKR/FSR clock
 source mux configuration
In-Reply-To: <1331198537-13469-2-git-send-email-peter.ujfalusi@ti.com>
References: <1331198537-13469-1-git-send-email-peter.ujfalusi@ti.com>
 <1331198537-13469-2-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120308211247.GZ12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120308 00:50]:
> On OMAP2/3 McBSP1 port has 6 pin setup, while on OMAP4 the port is McBSP4.
> Implement the CLKR/FSR clock mux selection for OMAP4, and make sure that
> we add the correct callback for the correct port across supported OMAP
> versions.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>

Acked-by: Tony Lindgren <tony@atomide.com>
