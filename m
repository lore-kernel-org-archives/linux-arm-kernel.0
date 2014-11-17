From: horms@verge.net.au (Simon Horman)
Date: Mon, 17 Nov 2014 10:39:58 +0900
Subject: [PATCH v2 0/2] ARM: shmobile: r8a7794: Add SGX, MMP and VSP1 to
 device tree
In-Reply-To: <1415782557-29550-1-git-send-email-horms+renesas@verge.net.au>
References: <1415782557-29550-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20141117013958.GM11143@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 12, 2014 at 05:55:55PM +0900, Simon Horman wrote:
> Hi,
> 
> this short series adds SGX, MMP and VSP1 clocks to device
> tree for the r8a7794 SoC
> 
> Based on the renesas-devel-20141112-v3.18-rc4 tag of my renesas tree
> 
> Changes between v1 and v2
> * Drop VIN patch which has been queued up
> * Address review by Geert Uytterhoeven as noted in per-patch changelogs
> 
> Kouei Abe (1):
>   ARM: shmobile: r8a7794: Add SGX clock to device tree
> 
> Yoshifumi Hosoya (1):
>   ARM: shmobile: r8a7794: Add MMP and VSP1 clocks to device tree
> 
>  arch/arm/boot/dts/r8a7794.dtsi            | 15 +++++++++------
>  include/dt-bindings/clock/r8a7794-clock.h |  7 +++++++
>  2 files changed, 16 insertions(+), 6 deletions(-)

I have queued up this series.
