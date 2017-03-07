From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 07 Mar 2017 14:58:54 +0000
Subject: [PATCH V3 3/4] KVM: arm/arm64: Remove KVM_PRIVATE_MEM_SLOTS
 definition that are unused
In-Reply-To: <1488865964-17346-4-git-send-email-linucherian@gmail.com>
 (linucherian@gmail.com's message of "Tue, 7 Mar 2017 11:22:43 +0530")
References: <1488865964-17346-1-git-send-email-linucherian@gmail.com>
 <1488865964-17346-4-git-send-email-linucherian@gmail.com>
Message-ID: <87efy9yvyp.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 07 2017 at  5:52:43 am GMT, linucherian at gmail.com wrote:
> From: Linu Cherian <linu.cherian@cavium.com>
>
> Signed-off-by: Linu Cherian <linu.cherian@cavium.com>

Please add a decent commit message. Even if this is an obvious patch,
explain the rational behind it. Patch 1 has the same problem.

Thanks,

	M.
-- 
Jazz is not dead, it just smell funny.
