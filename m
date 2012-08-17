From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Aug 2012 06:07:45 -0700
Subject: [PATCH v3 3/9] ARM: OMAP: board-am3517evm: Configure McBSP1
 CLKR/FSR signal source
In-Reply-To: <1345124468-8876-4-git-send-email-peter.ujfalusi@ti.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-4-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120817130744.GA11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120816 06:41]:
> am3517evm board uses McBSP1 for audio with 4pin configuration.
> The CLKR/FSR signals need to be connected to CLKX/FSX pin of the SoC in
> this case.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>

Acked-by: Tony Lindgren <tony@atomide.com>
