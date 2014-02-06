From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 6 Feb 2014 11:02:41 +0000
Subject: [PATCH v3 10/11] ARM: KVM: add world-switch for AMAIR{0,1}
In-Reply-To: <1391630151-7875-11-git-send-email-marc.zyngier@arm.com>
References: <1391630151-7875-1-git-send-email-marc.zyngier@arm.com>
 <1391630151-7875-11-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140206110241.GG29446@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 07:55:50PM +0000, Marc Zyngier wrote:
> HCR.TVM traps (among other things) accesses to AMAIR0 and AMAIR1.
> In order to minimise the amount of surprise a guest could generate by
> trying to access these registers with caches off, add them to the
> list of registers we switch/handle.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
