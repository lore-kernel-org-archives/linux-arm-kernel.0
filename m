From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 23 Oct 2015 19:00:55 +0000 (UTC)
Subject: [PATCH 1/2 v2] ARM: DRA7/335x/437x/OMAP4: hwmod: Remove elm
 address space from hwmod data
In-Reply-To: <1444926461-16092-1-git-send-email-fcooper@ti.com>
References: <1444926461-16092-1-git-send-email-fcooper@ti.com>
Message-ID: <alpine.DEB.2.02.1510231858170.9575@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Oct 2015, Franklin S Cooper Jr wrote:

> ELM address information is provided by device tree. No longer need
> to include this information within hwmod.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>

The OMAP4 DTS files don't have the ELM address space declared.  I'm going 
to drop that portion of your patch.  Could you please send a two-patch 
series that first adds the ELM address space to the OMAP4 DTS file and 
then subsequently drops it from the OMAP4 hwmod data file?


- Paul
