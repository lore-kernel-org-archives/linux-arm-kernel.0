From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 7 Mar 2018 18:13:59 +0000
Subject: [PATCH v5 12/23] arm64: insn: Allow ADD/SUB (immediate) with LSL
 #12
In-Reply-To: <20180301155538.26860-13-marc.zyngier@arm.com>
References: <20180301155538.26860-1-marc.zyngier@arm.com>
 <20180301155538.26860-13-marc.zyngier@arm.com>
Message-ID: <20180307181358.yypi56tmz4g3bcum@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 03:55:27PM +0000, Marc Zyngier wrote:
> The encoder for ADD/SUB (immediate) can only cope with 12bit
> immediates, while there is an encoding for a 12bit immediate shifted
> by 12 bits to the left.
> 
> Let's fix this small oversight by allowing the LSL_12 bit to be set.
> 
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
