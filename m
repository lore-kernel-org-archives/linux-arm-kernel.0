From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 23 May 2013 12:08:37 +0100
Subject: [PATCH v4 29/32] arm64: KVM: enable initialization of a 32bit vcpu
In-Reply-To: <1368540840-26750-30-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
 <1368540840-26750-30-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130523110837.GK16722@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 03:13:57PM +0100, Marc Zyngier wrote:
> Wire the init of a 32bit vcpu by allowing 32bit modes in pstate,
> and providing sensible defaults out of reset state.
> 
> This feature is of course conditioned by the presence of 32bit
> capability on the physical CPU, and is checked by the KVM_CAP_ARM_EL1_32BIT
> capability.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
