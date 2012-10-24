From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 24 Oct 2012 15:54:32 -0700
Subject: [PATCH 7/7] ARM: hw_breakpoint: use CRn as argument for debug
 reg accessor macros
In-Reply-To: <1350487901-3108-8-git-send-email-will.deacon@arm.com>
References: <1350487901-3108-1-git-send-email-will.deacon@arm.com>
 <1350487901-3108-8-git-send-email-will.deacon@arm.com>
Message-ID: <508871A8.1080906@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/12 08:31, Will Deacon wrote:
> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
>
> The coprocessor register CRn for accesses to the debug register can be a
> different one than C0. Take this into account for the ARM_DBG_READ and
> the ARM_DBG_WRITE macro.
>
> The inline assembler calls which used a coprocessor register CRn other
> than C0 are replaced by the ARM_DBG_READ or ARM_DBG_WRITE macro.
>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
>

Tested-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
