From: horms@verge.net.au (Simon Horman)
Date: Thu, 5 Dec 2013 14:28:11 +0900
Subject: [PATCH v2 0/3] ARM: shmobile: marzen: enable HSPI0 to DTS
In-Reply-To: <1385452032-11544-1-git-send-email-horms+renesas@verge.net.au>
References: <1385452032-11544-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20131205052810.GI12774@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 04:47:09PM +0900, Simon Horman wrote:
> Hi,
> 
> this short series enables HSPI0 in DTS for the r8a7779 based marzen board.
> It is based on work by Kuninori Morimoto for the r8a7778 based bockw board.
> 
> This series is based on the renesas-devel-v3.13-rc1-20131124 tag
> of my renesas tree.
> 
> v2
> * Correct clock suffixes in
>   "ARM: shmobile: r8a7779: add HSPI clock support for DT".
>   They should be ".spi" to match
>   "ARM: shmobile: r8a7779: add HSPI support to DTSI"
> 
> Simon Horman (3):
>   ARM: shmobile: r8a7779: add HSPI clock support for DT
>   ARM: shmobile: r8a7779: add HSPI support to DTSI
>   ARM: shmobile: marzen: enable HSPI0 in DTS
> 
>  arch/arm/boot/dts/r8a7779-marzen-reference.dts | 11 ++++++++++
>  arch/arm/boot/dts/r8a7779.dtsi                 | 30 ++++++++++++++++++++++++++
>  arch/arm/mach-shmobile/clock-r8a7779.c         |  3 +++
>  3 files changed, 44 insertions(+)

I will queue these up.
