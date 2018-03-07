From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 7 Mar 2018 18:09:51 +0000
Subject: [PATCH v5 02/23] arm64: insn: Add N immediate encoding
In-Reply-To: <20180301155538.26860-3-marc.zyngier@arm.com>
References: <20180301155538.26860-1-marc.zyngier@arm.com>
 <20180301155538.26860-3-marc.zyngier@arm.com>
Message-ID: <20180307180951.isvpenwdxkzj2avy@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 03:55:17PM +0000, Marc Zyngier wrote:
> We're missing the a way to generate the encoding of the N immediate,
> which is only a single bit used in a number of instruction that take
> an immediate.
> 
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
