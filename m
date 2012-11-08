From: horms@verge.net.au (Simon Horman)
Date: Thu, 8 Nov 2012 15:29:57 +0900
Subject: [GIT PULL v2] Renesas ARM-based SoC boards for v3.8 #2
In-Reply-To: <1352338056-21107-1-git-send-email-horms@verge.net.au>
References: <1352338056-21107-1-git-send-email-horms@verge.net.au>
Message-ID: <20121108062957.GB13151@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 08, 2012 at 10:27:29AM +0900, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> please consider the following board enhancements for 3.8.
> 
> * This pull-request is based on an earlier request which I
>   posted on the 1st and was merged yesterday: [GIT PULL v3] Renesas
>   ARM-based SoC boards for v3.8
> 
> * This pull request replaces the one that I sent yesterday:
>   [GIT PULL] Renesas ARM-based SoC boards for v3.8 #2
> 
> * Patch #2 of this series has a build-time dependency on
>   the soc pull request that I sent a few minutes ago:
>   [GIT PULL] Renesas ARM-based SoC for v3.8 #2
> 
>   In particular, "ARM: shmobile: marzen: add USB EHCI driver support"
>   depends on "[PATCH 1/7] ARM: shmobile: r8a7779: PFC rename PENCx -> USB_PENCx"
> 
> * Patch 4 of this pull-request is a driver patch which is a dependency
>   of patches 6 and 7 of this pull-request. I have spoken to the driver
>   maintainer, Paul Mundt, and he has indicated that he thinks it
>   is best to merge all in one go.
> 
>   In more detail:
> 
>   "sh: clkfwk: add sh_clk_fsidiv_register()" is a dependency of
>   - "ARM: shmobile: sh7372: use sh_clk_fsidiv_register() for FSI-DIV clocks"
>   - "ARM: shmobile: r8a7740: add FSI-DVI clocks"

I have found some problems with this pull-request,
I will send an revised one.
