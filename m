From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 9 Apr 2015 18:10:26 +0100
Subject: [PATCH 1/7] ARM: cache-v7: use movw/movt instructions
In-Reply-To: <E1YdzEv-0008Cf-9u@rmk-PC.arm.linux.org.uk>
References: <20150403100848.GZ24899@n2100.arm.linux.org.uk>
 <E1YdzEv-0008Cf-9u@rmk-PC.arm.linux.org.uk>
Message-ID: <20150409171026.GF23861@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 03, 2015 at 11:54:17AM +0100, Russell King wrote:
> We always build cache-v7.S for ARMv7, so we can use the ARMv7 16-bit
> move instructions to load large constants, rather than using constants
> in a literal pool.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
