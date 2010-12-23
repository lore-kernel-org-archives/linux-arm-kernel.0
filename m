From: sudhakar.raj@ti.com (Rajashekhara, Sudhakar)
Date: Thu, 23 Dec 2010 10:34:26 +0530
Subject: [PATCH v1] davinci: Add additional JTAG code for AM-1808 and
	OMAP-L138 Rev 2.0 SoCs
In-Reply-To: <87r5d9l54l.fsf@deeprootsystems.com>
References: <1293047363-21353-1-git-send-email-michael.williamson@criticallink.com>
	<87aajxpin1.fsf@deeprootsystems.com>	<4D128535.1000807@criticallink.com>
	<87r5d9l54l.fsf@deeprootsystems.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930247FAEEA9@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Thu, Dec 23, 2010 at 05:41:54, Kevin Hilman wrote:
> Michael Williamson <michael.williamson@criticallink.com> writes:
> 
> > On 12/22/2010 05:06 PM, Kevin Hilman wrote:
> >> Michael Williamson <michael.williamson@criticallink.com> writes:
> >> 
> >>> The JTAG variant code for Rev-2.0 silicon of the OMAP-L138 has changed.
> >>> In addition, the variant code for the AM-1808 SoC appears to match
> >>> the Rev-2.0 code for the OMAP-L138.  Add an additional entry to support
> >>> these chips.
> >> 
> >> Tested on?  
> >> 
> >> I'm assuming on the Mity platforms, right?
> >> 
> >
> > I tested this using an AM-1808 (456 MHz speedgrade) on a MityARM-1808
> > configured SoM.  I don't have a rev-2.0 silicon OMAP-L138 to try, but
> > according to the Rev B datasheet the variant will change as described.
> > It doesn't break the Rev 1 OMAP-L138 silicon MityDSP-L138F SoM.
> >
> > There was a thread about this in this list (link below) and I also 
> > have some background on an e2e link at TI (link below).  
> >
> > I had forgotten that I pulled this patch from Sudhakar Rajashekhara on the arago 
> > omapl PSP kernel (link to patch below).  It's really his work.
> >
> > I can resubmit (with tested-by and correct authorship) 
> 
> Yes please.  Also add the links to the threads mentioned above.
> 

Also, please add
Reported-by: Nicolas Luna <luna.id@gmail.com>

Thanks,
Sudhakar
