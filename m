From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 7 Mar 2018 18:12:53 +0000
Subject: [PATCH v5 11/23] arm64; insn: Add encoder for the EXTR instruction
In-Reply-To: <20180301155538.26860-12-marc.zyngier@arm.com>
References: <20180301155538.26860-1-marc.zyngier@arm.com>
 <20180301155538.26860-12-marc.zyngier@arm.com>
Message-ID: <20180307181252.jvmyxh3sasgnlhce@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 03:55:26PM +0000, Marc Zyngier wrote:
> Add an encoder for the EXTR instruction, which also implements the ROR
> variant (where Rn == Rm).
> 
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
