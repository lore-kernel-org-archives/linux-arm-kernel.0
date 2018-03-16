From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 16 Mar 2018 16:24:58 +0000
Subject: [PATCH v6 20/26] arm64: KVM: Move BP hardening vectors into
 .hyp.text section
In-Reply-To: <20180314165049.30105-21-marc.zyngier@arm.com>
References: <20180314165049.30105-1-marc.zyngier@arm.com>
 <20180314165049.30105-21-marc.zyngier@arm.com>
Message-ID: <20180316162457.67xkrist66vtp4mv@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2018 at 04:50:43PM +0000, Marc Zyngier wrote:
> There is no reason why the BP hardening vectors shouldn't be part
> of the HYP text at compile time, rather than being mapped at runtime.
> 
> Also introduce a new config symbol that controls the compilation
> of bpi.S.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
