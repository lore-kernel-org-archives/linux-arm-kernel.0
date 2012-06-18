From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 18 Jun 2012 10:04:20 -0600 (MDT)
Subject: [PATCH 0/3] ARM: OMAP2/3: Move McBSP fck alias to hwmod data
In-Reply-To: <1339676846-12791-1-git-send-email-peter.ujfalusi@ti.com>
References: <1339676846-12791-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <alpine.DEB.2.00.1206181004050.9031@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Thu, 14 Jun 2012, Peter Ujfalusi wrote:

> To keep the McBSP fck alias handling in sync among OMAP versions.
> Change the legacy implementation for OMAP2/3 regarding to McBSP fck alias.
> OMAP4 (and OMAP5) uses the hwmod data to specify the aliases for the fcks and
> it is also needed for the coming McBSP DT support.
> 
> Tested on OMAP3 BeagleBoard, compile tested it for OMAP2.

Thanks, queued for 3.6.


- Paul
