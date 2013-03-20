From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 20 Mar 2013 16:04:17 -0400
Subject: [PATCH 16/29] arm64: KVM: HYP mode world switch implementation
In-Reply-To: <5140DA96.3070403@codeaurora.org>
References: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
 <1362455265-24165-17-git-send-email-marc.zyngier@arm.com>
 <5140DA96.3070403@codeaurora.org>
Message-ID: <514A1641.6030709@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 03/13/2013 03:59 PM, Christopher Covington wrote:

[...]

> Alternatively, you could consider storing the host registers in a
> slimmed-down vcpu structure for hosts, rather than on the stack.

One potential argument for storing the host in the same sort of vcpu structure
as the guest rather than on the hypervisor stack is that snapshot and
migration support initially intended for guests might more easily be extended
to work for hosts as well.

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by
the Linux Foundation
