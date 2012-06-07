From: davidb@codeaurora.org (David Brown)
Date: Thu, 7 Jun 2012 13:23:34 -0700
Subject: [PATCH v7 07/12] ARM: SoC: convert MSM SMP to SoC descriptor
In-Reply-To: <1339085369-26073-8-git-send-email-marc.zyngier@arm.com>
References: <1339085369-26073-1-git-send-email-marc.zyngier@arm.com>
 <1339085369-26073-8-git-send-email-marc.zyngier@arm.com>
Message-ID: <20120607202334.GA21739@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 07, 2012 at 05:09:24PM +0100, Marc Zyngier wrote:

> Convert MSM SMP platforms to use the SoC descriptor to provide
> their SMP and CPU hotplug operations.
> 
> Cc: David Brown <davidb@codeaurora.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/mach-msm/Makefile        |    2 +-
>  arch/arm/mach-msm/board-msm8960.c |    3 +++
>  arch/arm/mach-msm/board-msm8x60.c |    7 +++++++
>  arch/arm/mach-msm/core.c          |   17 +++++++++++++++++
>  arch/arm/mach-msm/core.h          |    9 +++++++++
>  arch/arm/mach-msm/hotplug.c       |    8 +++++---
>  arch/arm/mach-msm/platsmp.c       |   20 ++++++++++++++++----
>  7 files changed, 58 insertions(+), 8 deletions(-)
>  create mode 100644 arch/arm/mach-msm/core.c
>  create mode 100644 arch/arm/mach-msm/core.h

I've tested this on msm targets, although msm7201 isn't currently
building in linux-next because of an RCU issue, but I don't think it
breaks anything there.

Tested-by: David Brown <davidb@codeaurora.org>
Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
