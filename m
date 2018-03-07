From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 7 Mar 2018 18:10:26 +0000
Subject: [PATCH v5 03/23] arm64: insn: Add encoder for bitwise operations
 using literals
In-Reply-To: <20180301155538.26860-4-marc.zyngier@arm.com>
References: <20180301155538.26860-1-marc.zyngier@arm.com>
 <20180301155538.26860-4-marc.zyngier@arm.com>
Message-ID: <20180307181025.chs2r6cbmgnkroit@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 03:55:18PM +0000, Marc Zyngier wrote:
> We lack a way to encode operations such as AND, ORR, EOR that take
> an immediate value. Doing so is quite involved, and is all about
> reverse engineering the decoding algorithm described in the
> pseudocode function DecodeBitMasks().
> 
> This has been tested by feeding it all the possible literal values
> and comparing the output with that of GAS.
> 
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
