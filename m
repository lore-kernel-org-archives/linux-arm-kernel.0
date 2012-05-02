From: davidb@codeaurora.org (David Brown)
Date: Wed, 2 May 2012 11:28:41 -0700
Subject: [PATCH 06/15] ARM: msm: use machine specific hook for late init
In-Reply-To: <1335958420-5193-7-git-send-email-shawn.guo@linaro.org>
References: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
 <1335958420-5193-7-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120502182841.GA26165@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 07:33:31PM +0800, Shawn Guo wrote:
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Daniel Walker <dwalker@fifo99.com>
> Cc: Bryan Huntsman <bryanh@codeaurora.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/mach-msm/board-halibut.c      |    6 ++++++
>  arch/arm/mach-msm/board-mahimahi.c     |    6 ++++++
>  arch/arm/mach-msm/board-msm7x27.c      |    9 +++++++++
>  arch/arm/mach-msm/board-msm7x30.c      |    8 ++++++++
>  arch/arm/mach-msm/board-msm8960.c      |    7 +++++++
>  arch/arm/mach-msm/board-msm8x60.c      |   10 ++++++++++
>  arch/arm/mach-msm/board-qsd8x50.c      |    7 +++++++
>  arch/arm/mach-msm/board-sapphire.c     |    6 ++++++
>  arch/arm/mach-msm/board-trout.c        |    6 ++++++
>  arch/arm/mach-msm/include/mach/board.h |    6 ++++++
>  arch/arm/mach-msm/smd_debug.c          |    3 +--
>  11 files changed, 72 insertions(+), 2 deletions(-)

Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
