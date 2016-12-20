From: horms@verge.net.au (Simon Horman)
Date: Tue, 20 Dec 2016 11:51:44 +0100
Subject: [PATCH v2 renesas/devel 00/13] ARM, arm64: dts: Use R-Car
 fallback bindings for i2c/iic nodes
In-Reply-To: <1481629559-14187-1-git-send-email-horms+renesas@verge.net.au>
References: <1481629559-14187-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20161220105144.GJ19532@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2016 at 12:45:46PM +0100, Simon Horman wrote:
> Hi,
> 
> this short series makes use of newly added R-Car fallback bindings in i2c
> and iic nodes of the DTs for SoCs where the drivers in question are already
> used.
> 
> This should have no run-time effect at this time as the current driver
> implementations use the same initialisation squeuences for SoC-specific and
> R-Car fallback bindings for all the cases covered by this patch-set.
> 
> Based on renesas-devel-20161212-v4.9

I have queued these up for v4.11.
