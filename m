From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 May 2014 16:17:35 -0700
Subject: [PATCH v2 4/5] ARM: dts: am33xx: Remove obsolete properties from
 edma node
In-Reply-To: <1399977032-26469-5-git-send-email-peter.ujfalusi@ti.com>
References: <1399977032-26469-1-git-send-email-peter.ujfalusi@ti.com>
 <1399977032-26469-5-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20140514231734.GC13427@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [140513 03:31]:
> dma-channels, ti,edma-regions and ti,edma-slots no longer needed in DT since
> the the same information is available in the IP's CCCFG register.

Sounds like this must go with the edma patches or else
applied later on. Probably best to merge it with edma:

Acked-by: Tony Lindgren <tony@atomide.com>
