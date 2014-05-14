From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 May 2014 16:18:07 -0700
Subject: [PATCH v2 5/5] ARM: dts: am4372: Remove obsolete properties from
 edma node
In-Reply-To: <1399977032-26469-6-git-send-email-peter.ujfalusi@ti.com>
References: <1399977032-26469-1-git-send-email-peter.ujfalusi@ti.com>
 <1399977032-26469-6-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20140514231807.GD13427@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [140513 03:31]:
> dma-channels, ti,edma-regions and ti,edma-slots no longer needed in DT since
> the the same information is available in the IP's CCCFG register.

This too:

Acked-by: Tony Lindgren <tony@atomide.com>
