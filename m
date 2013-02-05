From: horms@verge.net.au (Simon Horman)
Date: Tue, 5 Feb 2013 17:15:39 +0900
Subject: [PATCH] ARM: shmobile: Register ARM architected timer
In-Reply-To: <20130205073049.7576.51324.sendpatchset@w520>
References: <20130205073049.7576.51324.sendpatchset@w520>
Message-ID: <20130205081538.GA14681@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 04:30:49PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Register ARM architected timer by default for all mach-shmobile
> systems using late timer.

Thanks, applied to a new soc4 branch and merged into next.
