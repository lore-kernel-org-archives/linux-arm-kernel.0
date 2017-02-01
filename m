From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 1 Feb 2017 16:22:15 +0000
Subject: [PATCH 04/10] arm64: head.S: Enable EL1 (host) access to SPE when
 entered at EL2
In-Reply-To: <1485540470-11469-5-git-send-email-will.deacon@arm.com>
References: <1485540470-11469-1-git-send-email-will.deacon@arm.com>
 <1485540470-11469-5-git-send-email-will.deacon@arm.com>
Message-ID: <8b3f5174-cbe4-c6cd-3179-fa4d32868b46@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/01/17 18:07, Will Deacon wrote:
> The SPE architecture requires each exception level to enable access
> to the SPE controls for the exception level below it, since additional
> context-switch logic may be required to handle the buffer safely.
> 
> This patch allows EL1 (host) access to the SPE controls when entered at
> EL2.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Definitely more readable than the initial version! ;-)

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
