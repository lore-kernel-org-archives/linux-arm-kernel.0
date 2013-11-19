From: horms@verge.net.au (Simon Horman)
Date: Tue, 19 Nov 2013 11:40:32 +0900
Subject: [PATCH v2 2/7] ARM: shmobile: Use interrupt macros in SoC DT files
In-Reply-To: <1384827505-25015-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383999839-3339-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1384827505-25015-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20131119024032.GM17628@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 03:18:25AM +0100, Laurent Pinchart wrote:
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/boot/dts/r8a73a4.dtsi | 108 ++++++++++++++++++++++++----------
>  arch/arm/boot/dts/r8a7740.dtsi | 106 +++++++++++++++++-----------------
>  arch/arm/boot/dts/r8a7778.dtsi |  44 +++++++-------
>  arch/arm/boot/dts/r8a7779.dtsi |  42 +++++++-------
>  arch/arm/boot/dts/r8a7790.dtsi |  50 +++++++++-------
>  arch/arm/boot/dts/r8a7791.dtsi |  49 ++++++++--------
>  arch/arm/boot/dts/sh73a0.dtsi  | 128 +++++++++++++++++++++--------------------
>  7 files changed, 295 insertions(+), 232 deletions(-)
> 
> Rebased on top of Simon's dt3 branch.

Thanks, this one applied cleanly.
I have queued it up in place of v1.
