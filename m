From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 1 Sep 2016 13:11:54 +0100
Subject: [PATCH] KVM: arm/arm64: Get rid of exported aliases to static
 functions
In-Reply-To: <20160901111806.14972-1-christoffer.dall@linaro.org>
References: <20160901111806.14972-1-christoffer.dall@linaro.org>
Message-ID: <57C81B0A.2050003@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/16 12:18, Christoffer Dall wrote:
> When rewriting the assembly code to C code, it was useful to have
> exported aliases or static functions so that we could keep the existing
> common C code unmodified and at the same time rewrite arm64 from
> assembly to C code, and later do the arm part.
> 
> Now when both are done, we really don't need this level of indirection
> anymore, and it's time to save a few lines and brain cells.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
