From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Aug 2012 06:08:02 -0700
Subject: [PATCH v3 4/9] ASoC: am3517evm: Do not configure McBSP1
 CLKR/FSR signal muxing
In-Reply-To: <1345124468-8876-5-git-send-email-peter.ujfalusi@ti.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-5-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120817130802.GB11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120816 06:41]:
> The muxing is done at board level, no need to do it in the ASoC machine
> driver.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>

Acked-by: Tony Lindgren <tony@atomide.com>
