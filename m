From: nm@ti.com (Nishanth Menon)
Date: Fri, 19 Nov 2010 09:32:42 -0600
Subject: [PATCH v4] OMAP2+: PM: omap device: API's for handling mstandby
	mode
In-Reply-To: <1290151312-347-1-git-send-email-manjugk@ti.com>
References: <1290151312-347-1-git-send-email-manjugk@ti.com>
Message-ID: <4CE6989A.7070007@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

G, Manjunath Kondaiah had written, on 11/19/2010 01:21 AM, the following:
> Certain errata's in OMAP2+ processors will require forcing
> master standby to "no standby" mode before completing on going
> operation. Without this, the results will be unpredictable.
> 
[..]
> These API's are required for multiple DMA errata's which require
> putting DMA controller in no mstandby mode before stopping dma.
> 
> The applicable errata's:
> 1. Errata ID: i557(Applicable for omap36xx all ES versions)
> The channel hangs when the Pause bit (DMA4_CDPi [7] ) is cleared
> through config port while in Standby.
> 
> 2. Errata ID: i541(all omap2plus except omap4)
> sDMA FIFO draining does not finish
> 
> 3. OMAP3430 ES1.0(Errata ID:i88) will require DMA to be put in
> no mstandby mode before disabling the channel after completing
> the data transfer operation.

Minor feedback from what I got from an offline comment:
1 bug = Erratum
1+ bug = Errata

-- 
Regards,
Nishanth Menon
