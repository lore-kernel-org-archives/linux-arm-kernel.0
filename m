From: cov@codeaurora.org (Christopher Covington)
Date: Mon, 18 Mar 2013 14:56:42 -0400
Subject: [PATCH 29/29] arm64: KVM: enable initialization of a 32bit vcpu
In-Reply-To: <1362455265-24165-30-git-send-email-marc.zyngier@arm.com>
References: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
 <1362455265-24165-30-git-send-email-marc.zyngier@arm.com>
Message-ID: <5147636A.2010309@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2013 10:47 PM, Marc Zyngier wrote:
> Wire the init of a 32bit vcpu by allowing 32bit modes in pstate,
> and providing sensible defaults out of reset state.
> 
> This feature is of course conditionned by the presence of 32bit

conditioned

> capability on the physical CPU.

[...]

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by
the Linux Foundation
