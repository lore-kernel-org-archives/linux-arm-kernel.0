From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 14 Mar 2013 10:26:25 +0000
Subject: [PATCH 10/29] arm64: KVM: Cortex-A57 specific system registers
 handling
In-Reply-To: <5140C5BB.7010401@codeaurora.org>
References: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
 <1362455265-24165-11-git-send-email-marc.zyngier@arm.com>
 <5140C5BB.7010401@codeaurora.org>
Message-ID: <5141A5D1.9080109@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/03/13 18:30, Christopher Covington wrote:

Hi Christopher,

> I wonder if two of these registers could be handled in a generic fashion.

[...]

> What's A57-specific about this MPIDR behavior?

[...]

> What's A57-specific about this CPACR behavior?

In both cases, nothing I can think of. They both should be moved to the
generic sys_reg code.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
