From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 7 Dec 2010 23:20:20 -0700 (MST)
Subject: [PATCH 00/14] OMAP: PRCM/powerdomain/clockdomain patches for
	2.6.38, part one
In-Reply-To: <87wrnli0ep.fsf@deeprootsystems.com>
References: <20101207012242.3708.45451.stgit@twilight.localdomain>
	<87wrnli0ep.fsf@deeprootsystems.com>
Message-ID: <alpine.DEB.2.00.1012072320030.13430@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 7 Dec 2010, Kevin Hilman wrote:

> Paul Walmsley <paul@pwsan.com> writes:
> 
> > This patch series, intended for 2.6.38:
> 
> [...]
> 
> > Kevin, I'd appreciate review and acks, if appropriate, on the patches
> > that touch code that you maintain.  
> 
> Reviewed-by: Kevin Hilman <khilman@deeprootsystems.com>
> Tested-by: Kevin Hilman <khilman@deeprootsystems.com>
> 
> I did some PM testing of this series on 34xx/n900 and 35xx/beagle using
> retention idle & sususpend and off-idle and suspend.
> 
> For testing with other PM features that are targetted for 2.6.38, I've
> included it as part of my pm-core branch (which also includes your
> previous hwmod series and the watchdog series, among other things.)

Thanks for testing, Kevin, I'll update the patches accordingly.


- Paul
