From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 5 Dec 2010 21:45:23 +0000
Subject: [PATCH 1/5] ARM: GIC: provide a single initialization function
	for boot CPU
In-Reply-To: <E1PPCrC-0004xO-Fs@rmk-PC.arm.linux.org.uk>
References: <20101205113311.GC9138@n2100.arm.linux.org.uk>
	<E1PPCrC-0004xO-Fs@rmk-PC.arm.linux.org.uk>
Message-ID: <AANLkTikRW3ScQBoSPetNvCLuZ0oA3BvuHB5JqigNhMOi@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 December 2010 11:34, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Provide gic_init() which initializes the GIC distributor and current
> CPU's GIC interface for the boot (or single) CPU.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
