From: horms@verge.net.au (Simon Horman)
Date: Mon, 15 Feb 2016 10:54:21 +0900
Subject: [PATCH 0/2] ARM: shmobile: r8a779x: use fallback pcie
 compatibility string
In-Reply-To: <1450406163-23795-1-git-send-email-horms+renesas@verge.net.au>
References: <1450406163-23795-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20160215015421.GB14034@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Cc: linux-renesas-soc at vger.kernel.org]

On Fri, Dec 18, 2015 at 11:36:01AM +0900, Simon Horman wrote:
> Hi,
> 
> this short series makes use of the recently added fallback pcie
> compatibility string in the r8a779[01] device trees.
> 
> Based on renesas-devel-20151218-v4.4-rc5.
> 
> Simon Horman (2):
>   ARM: shmobile: r8a7790: use fallback pcie compatibility string
>   ARM: shmobile: r8a7791: use fallback pcie compatibility string
> 
>  arch/arm/boot/dts/r8a7790.dtsi | 2 +-
>  arch/arm/boot/dts/r8a7791.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

I have queued these up for v4.6.
