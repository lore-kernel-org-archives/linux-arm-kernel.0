From: tony@atomide.com (Tony Lindgren)
Date: Tue, 5 Oct 2010 11:15:25 -0700
Subject: [PATCH v5 0/3] OMAP2/3: DMA: FIFO drain errata fixes
In-Reply-To: <1286261141-1039-1-git-send-email-peter.ujfalusi@nokia.com>
References: <1286261141-1039-1-git-send-email-peter.ujfalusi@nokia.com>
Message-ID: <20101005181525.GL3117@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@nokia.com> [101004 23:37]:
> Hello,
> 
> This v5 series is based on the v3.
> The first two patch is the actual fix for the original problems without any
> major change in the code (only handling the corresponding erratas in the legacy
> way).
> The third patch in the series is optional, and it is implementing (in one patch)
> the errata handling via flags. This patch converts all errata cases to use the
> introduced dma_errata variable via macros.
> 
> Tony: the first two patch need to go for 2.6.36, and if it is possible it shall
> be backported to .33, .34, and .35 as well.

OK, I'll the first two into omap-fixes.

> The final patch in this series is optional, if you feel like you can take it
> (or drop it). AFAIK the upcoming hwmod changes to dma code will also have
> similar feature to handle the erratas.
> I'm not sure what is the schedule for the hwmod conversion of dma...

Let's queue this clean-up with the hwmod patches then.

Regards,

Tony
