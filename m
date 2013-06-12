From: tony@atomide.com (Tony Lindgren)
Date: Wed, 12 Jun 2013 10:31:20 -0700
Subject: [PATCH] ARM: OMAP4: hwmod data: Remove irq entries from mcspi,
 mmc hwmods
In-Reply-To: <1370846720-6709-1-git-send-email-r.sricharan@ti.com>
References: <1370846720-6709-1-git-send-email-r.sricharan@ti.com>
Message-ID: <20130612173120.GO8164@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sricharan R <r.sricharan@ti.com> [130609 23:51]:
> Commit '3b9b10151c6838af52244cec4af41a938bb5b7ec' cleaned up the
> data file to remove all irq and dma entries for all hwmods, which
> are now populated by DT. But mcspi and mmc irq, dma entries were
> retained since MMC, NFS boot was not working. Since it is root caused
> to be an issue with only DMA entries [1], irq can be safely removed.
> 
> [1] http://www.mail-archive.com/linux-omap at vger.kernel.org/msg90115.html

Thanks applying into omap-for-v3.11/cleanup.

Regards,

Tony
