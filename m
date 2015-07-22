From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 22 Jul 2015 16:55:54 +0100
Subject: [PATCH v3 4/5] arm64: kvm: Adopt new alternative assembler macros
In-Reply-To: <20150722151739.GM6650@arm.com>
References: <1436536130-31438-1-git-send-email-daniel.thompson@linaro.org>
 <1437564065-4356-1-git-send-email-daniel.thompson@linaro.org>
 <1437564065-4356-5-git-send-email-daniel.thompson@linaro.org>
 <20150722151739.GM6650@arm.com>
Message-ID: <55AFBD0A.2040700@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/07/15 16:17, Will Deacon wrote:

Hi Will,

> On Wed, Jul 22, 2015 at 12:21:04PM +0100, Daniel Thompson wrote:
>> Convert the dynamic patching for ARM64_HAS_SYSREG_GIC_CPUIF over to
>> the newly added alternative assembler macros.
> 
> Do you mind if I take this via the arm64 tree? It won't apply in
> isolation and I'd expect conflicts to be small/trivial to resolve.

Looks perfectly sensible to me, and I'm happy for you to take this. I
don't believe we have anything queued for 4.3 that would clash with this
anyway.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
