From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Tue, 25 Jan 2011 05:32:05 +0530
Subject: [PATCH] OMAP2+: remove unused UART base addresses from
	omap_globals
In-Reply-To: <87wrlu6k8l.fsf@ti.com>
References: <1295649015-26348-1-git-send-email-khilman@ti.com>
	<20110124064154.GA16582@m-desktop>
	<20110124074520.GB16582@m-desktop> <87wrlu6k8l.fsf@ti.com>
Message-ID: <20110125000205.GB6351@manju-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 01:54:18PM -0800, Kevin Hilman wrote:
> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
> 
> > We need additional changes for removing these macros since omap2+ till
> > omap3 hwmod uart db is not using dma request lines in omap4 way.
> 
> Feel free to send the DMA changes as an additional patch.  This is
> independent of my changes, so can be a separate patch.
No problem. I have cleanup changes for other drivers also so I can merge these
changes.

-Manjunath
[...]
