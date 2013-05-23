From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 23 May 2013 11:46:07 +0100
Subject: [PATCH v4 22/32] arm64: KVM: define 32bit specific registers
In-Reply-To: <1368540840-26750-23-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
 <1368540840-26750-23-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130523104607.GD16722@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 03:13:50PM +0100, Marc Zyngier wrote:
> Define the 32bit specific registers (SPSRs, cp15...).
> 
> Most CPU registers are directly mapped to a 64bit register
> (r0->x0...). Only the SPSRs have separate registers.
> 
> cp15 registers are also mapped into their 64bit counterpart in most
> cases.
> 
> Reviewed-by: Christopher Covington <cov@codeaurora.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
