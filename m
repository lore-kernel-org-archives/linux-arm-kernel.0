From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 17 Jan 2018 11:52:11 +0000
Subject: [PATCH] arm64: mm: Add additional parameter to
 uaccess_ttbr0_disable
In-Reply-To: <20180117113850.21949-1-christoffer.dall@linaro.org>
References: <20180117113850.21949-1-christoffer.dall@linaro.org>
Message-ID: <20180117115211.itijfrz6o6xibf7n@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 12:38:50PM +0100, Christoffer Dall wrote:
> Add an extra temporary register parameter to uaccess_ttbr0_disable which
> is about to be required for arm64 PAN support.
> 
> This patch doesn't introduce any functional change but ensures that the
> kernel compiles once the KVM/ARM tree is merged with the arm64 tree by
> ensuring a trivially mergable conflict with commit
> 6b88a32c7af68895134872cdec3b6bfdb532d94e
> ("arm64: kpti: Fix the interaction between ASID switching and software PAN").
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
