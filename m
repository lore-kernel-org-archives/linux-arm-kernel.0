From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 9 Jun 2017 11:38:00 +0100
Subject: [PATCH 08/31] arm64: Add a facility to turn an ESR syndrome into
 a sysreg encoding
In-Reply-To: <20170503104606.19342-9-marc.zyngier@arm.com>
References: <20170503104606.19342-1-marc.zyngier@arm.com>
 <20170503104606.19342-9-marc.zyngier@arm.com>
Message-ID: <20170609103800.GG2186@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 03, 2017 at 11:45:43AM +0100, Marc Zyngier wrote:
> It is often useful to compare an ESR syndrome reporting the trapping
> of a system register with a value matching that system register.
> 
> Since encoding both the sysreg and the ESR version seem to be a bit
> overkill, let's add a set of macros that convert an ESR value into
> the corresponding sysreg encoding.
> 
> We handle both AArch32 and AArch64, taking advantage of identical
> encodings between system registers and CP15 accessors.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
