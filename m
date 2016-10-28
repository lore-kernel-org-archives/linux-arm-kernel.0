From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 28 Oct 2016 16:16:11 +0100
Subject: [PATCH 2/2] irqchip/gic-v3: Use nops macro for Cavium ThunderX
 erratum 23154
In-Reply-To: <1477653838-21569-2-git-send-email-will.deacon@arm.com>
References: <1477653838-21569-1-git-send-email-will.deacon@arm.com>
 <1477653838-21569-2-git-send-email-will.deacon@arm.com>
Message-ID: <2016ac6f-3921-4053-c50d-c1d8adf42798@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 28/10/16 12:23, Will Deacon wrote:
> The workaround for Cavium ThunderX erratum 23154 has a homebrew
> pipeflush built out of NOP sequences around the read of the IAR.
> 
> This patch converts the code to use the new nops macro, which makes it
> a little easier to read.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Both patches queued for 4.10.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
