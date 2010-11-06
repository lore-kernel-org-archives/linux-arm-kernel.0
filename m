From: horms@verge.net.au (Simon Horman)
Date: Sat, 6 Nov 2010 09:28:59 +0900
Subject: [patch v3 0/2] ARM: mach-shmobile: Add zboot support for
	SuperH Mobile ARM
In-Reply-To: <20101014091231.858799238@vergenet.net>
References: <20101014091231.858799238@vergenet.net>
Message-ID: <20101106002859.GB22926@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 14, 2010 at 06:12:31PM +0900, Simon Horman wrote:
> Hi,
> 
> this short patch series by Kuninori Morimoto and myself adds
> zboot support to mach-shmobile.
> 
> This is v3 of this patch series. It implements Magnus's suggestion
> of initialising atags directly rather than using assembly.
> 
> v2 implemented Magnus's suggestion of setting atags in the framework and
> passing them to the kernel rather than using a board-specific fixup.

Russell, do you have any thoughts on this series?
