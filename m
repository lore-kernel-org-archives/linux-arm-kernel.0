From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jan 2010 16:35:07 +0000
Subject: [PATCH 1/3] arm: use generic infrastructure for early params
In-Reply-To: <1262835561.887596.484530867548.1.gpush@pororo>
References: <1262835561.887063.943450380979.0.gpush@pororo>
	<1262835561.887596.484530867548.1.gpush@pororo>
Message-ID: <20100108163507.GD32558@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 07, 2010 at 02:39:21PM +1100, Jeremy Kerr wrote:
> The ARM setup code includes its own parser for early params, there's
> also one in the generic init code.
> 
> This patch removes __early_init (and related code) from
> arch/arm/kernel/setup.c, and changes users to the generic early_init
> macro instead.
> 
> The generic macro takes a char * argument, rather than char **, so we
> need to update the parser functions a little.
> 
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

Any chance of having this in the patch system please?

Thanks.
