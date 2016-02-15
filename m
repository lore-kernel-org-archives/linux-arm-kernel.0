From: horms@verge.net.au (Simon Horman)
Date: Mon, 15 Feb 2016 10:55:42 +0900
Subject: [PATCH 0/3] ARM: shmobile: r8a779x: use fallback pcie
 compatibility string
In-Reply-To: <1450406559-9076-1-git-send-email-horms+renesas@verge.net.au>
References: <1450406559-9076-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20160215015542.GC14034@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Cc linux-renesas-soc at vger.kernel.org]

On Fri, Dec 18, 2015 at 11:42:36AM +0900, Simon Horman wrote:
> Hi,
> 
> this short series makes use of the recently added fallback pci
> compatibility string in the r8a779[014] device trees.
> 
> Based on renesas-devel-20151218-v4.4-rc5.
> 
> Simon Horman (3):
>   ARM: shmobile: r8a7790: use fallback pci compatibility string
>   ARM: shmobile: r8a7791: use fallback pci compatibility string
>   ARM: shmobile: r8a7794: use fallback pci compatibility string
> 
>  arch/arm/boot/dts/r8a7790.dtsi | 6 +++---
>  arch/arm/boot/dts/r8a7791.dtsi | 4 ++--
>  arch/arm/boot/dts/r8a7794.dtsi | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)

I have queued these up for v4.6
