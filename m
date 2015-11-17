From: horms@verge.net.au (Simon Horman)
Date: Tue, 17 Nov 2015 11:28:32 -0800
Subject: [PATCH 0/4] ARM: shmobile: Use SoC specific binding for
 rcar-dmac nodes
In-Reply-To: <1447381431-2255-1-git-send-email-horms+renesas@verge.net.au>
References: <1447381431-2255-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20151117192832.GN23979@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 13, 2015 at 11:23:47AM +0900, Simon Horman wrote:
> Use the new SoC specific binding for rcar-dmac and the generic
> binding as a fall-back in the r8a779[0134] device trees.
> 
> In general Renesas hardware is not documented to the extent where the
> relationship between IP blocks on different SoCs can be assumed although
> they may appear to operate the same way. Furthermore the documentation
> typically does not specify a version for individual IP blocks. For these
> reasons a convention of using the SoC name in place of a version and
> providing SoC-specific compat strings has been adopted.
> 
> Although not universally liked this convention is used in the bindings for
> most drivers for Renesas hardware. The purpose of this patch is to
> update the Renesas R-Car DMA Controller nodes to follow this convention.

As the bindings in question have now been accepted
I have queued up this series for v4.5.
