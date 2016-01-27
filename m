From: horms@verge.net.au (Simon Horman)
Date: Wed, 27 Jan 2016 20:24:03 +0900
Subject: [PATCH v4 00/14] r8a7793, gose: Add audio support to device tree
In-Reply-To: <1453094889-25204-1-git-send-email-horms+renesas@verge.net.au>
References: <1453094889-25204-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20160127112403.GB26357@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2016 at 02:27:55PM +0900, Simon Horman wrote:
> Hi,
> 
> this series adds support to r8a7793 and gose device trees for
> rcar sound: first in PIO mode then using DMA
> 
> I have been unable to test if audio works (in PIO mode) as I
> do not have physical access to a gose board. I would appreciate
> some assistance there.

I have been able to perform some basic testing and have queued up this
series.

> This work is based heavily on the work of others for the r8a7791 and
> koelsch as noted in the changelogs of individual patches.
> 
> This series is based on renesas-devel-20160111-v4.4 and
> has no other dependencies that I am aware of.

[snip]
