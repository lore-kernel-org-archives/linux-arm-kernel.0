From: horms@verge.net.au (Simon Horman)
Date: Wed, 15 Jan 2014 17:30:30 +0900
Subject: [PATCH] ARM: shmobile: Break out R-Car SYSC PM code
In-Reply-To: <20140115074308.8471.64824.sendpatchset@w520>
References: <20140115074308.8471.64824.sendpatchset@w520>
Message-ID: <20140115083027.GC16455@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 15, 2014 at 04:43:08PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Break out the R-Car SYSC power management code from
> the r8a7779 SoC code. With this new shared R-Car SYSC
> code base it is possible to hook in Generation 2 SoCs
> as well.

Is this also useful for the r8a7778 (the other Gen 1 SoC in mainline) ?
