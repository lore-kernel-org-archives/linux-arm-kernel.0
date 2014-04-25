From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 25 Apr 2014 13:46:52 +0100
Subject: [PATCH] ARM: KVM: disable KVM in Kconfig on big-endian systems
In-Reply-To: <1398422764-29351-1-git-send-email-will.deacon@arm.com>
References: <1398422764-29351-1-git-send-email-will.deacon@arm.com>
Message-ID: <535A593C.6020408@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/04/14 11:46, Will Deacon wrote:
> KVM currently crashes and burns on big-endian hosts, so don't allow it
> to be selected until we've got that fixed.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
