From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 4 Oct 2012 17:23:34 +0530
Subject: [PATCH v3 2/6] ARM: davinci: da850-dm646x: remove the SRAM_VIRT
 iotable entry
In-Reply-To: <1349276133-26408-3-git-send-email-mporter@ti.com>
References: <1349276133-26408-1-git-send-email-mporter@ti.com>
 <1349276133-26408-3-git-send-email-mporter@ti.com>
Message-ID: <506D78BE.1000607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/3/2012 8:25 PM, Matt Porter wrote:
> From: Ben Gardiner <bengardiner@nanometrics.ca>
> 
> The sram regions defined for da850-dm646x in their iotable entries are also
> defined in their davinci_soc_info's.
> 
> Remove this duplicate information which is now uneccessary since sram
> init will ioremap the regions defined by their davinci_soc_info's.
> 
> Since this removal completely removes all uses of SRAM_VIRT, also remove
> the SRAM_VIRT definition.
> 
> Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
> Tested-by: Matt Porter <mporter@ti.com>

What testing was done with this patch? Can you please add that
information to the commit text as well.

Thanks,
Sekhar
