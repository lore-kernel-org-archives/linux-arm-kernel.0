From: davidb@codeaurora.org (David Brown)
Date: Tue, 30 Jul 2013 13:55:32 -0700
Subject: [PATCH v2 3/9] ARM: msm: Move debug-macro.S to include/debug
In-Reply-To: <1374699274-18388-4-git-send-email-sboyd@codeaurora.org>
References: <1374699274-18388-1-git-send-email-sboyd@codeaurora.org>
 <1374699274-18388-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130730205532.GA18638@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 01:54:28PM -0700, Stephen Boyd wrote:
>One more step to allowing MSM to participate in the
>multi-platform defconfig.

Full patch: https://patchwork.kernel.org/patch/2833034/

>Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>---
> arch/arm/Kconfig.debug                             |  9 +++-
> .../mach/debug-macro.S => include/debug/msm.S}     | 32 ++++++++++-
> arch/arm/mach-msm/include/mach/msm_iomap-8960.h    |  5 --
> arch/arm/mach-msm/include/mach/msm_iomap-8x60.h    |  5 --
> arch/arm/mach-msm/include/mach/msm_iomap.h         | 12 -----
> arch/arm/mach-msm/include/mach/uncompress.h        | 63 ----------------------
> arch/arm/mach-msm/io.c                             | 40 +++++++-------
> 7 files changed, 58 insertions(+), 108 deletions(-)
> rename arch/arm/{mach-msm/include/mach/debug-macro.S => include/debug/msm.S} (61%)
> delete mode 100644 arch/arm/mach-msm/include/mach/uncompress.h

Any comments on this?  This is mostly an MSM change, but I'd like to
get an Ack from someone because of the file moving into
arch/arm/include/debug.

Thanks,
David

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
