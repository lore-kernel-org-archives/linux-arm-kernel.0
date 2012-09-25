From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 25 Sep 2012 07:37:53 +0200
Subject: [PATCH 0/6] Dove fixes for arm-soc/for-next
In-Reply-To: <1348531338-16624-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1348531338-16624-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20120925053753.GL14266@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2012 at 02:02:12AM +0200, Sebastian Hesselbarth wrote:
> With the current speed of changes within arm kernel tree, there
> have been some issues related to the mach-dove DT support patches
> introduced lately. This patch set keeps up with the changes between
> initial patch submission and current status of arm-soc/for-next.
> 
> Sebastian Hesselbarth (6):
>   ARM: dove: Add pcie clock support
>   ARM: dove: Fix tauros2 device tree init
>   ARM: dove: Fix clock names of sata and gbe
>   ARM: dove: Restructure SoC device tree descriptor
>   ARM: dove: Remove watchdog from DT
>   ARM: dove: Add crypto engine to DT
> 
>  arch/arm/boot/dts/dove.dtsi |   49 ++++++++++++++++++++++++++++---------------
>  arch/arm/mach-dove/common.c |    8 +++----
>  arch/arm/mach-dove/pcie.c   |    5 +++++
>  3 files changed, 41 insertions(+), 21 deletions(-)

Its a bit late, Jason has already sent the pull request. But:

Acked-by: Andrew Lunn <andrew@lunn.ch>

None of my questions should be considered as NACKs for these patches.

     Andrew
