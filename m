From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 5 Dec 2010 22:01:13 +0000
Subject: [PATCH 3/5] ARM: GIC: consolidate gic_cpu_base_addr to common GIC
	code
In-Reply-To: <E1PPCrr-0004xW-2c@rmk-PC.arm.linux.org.uk>
References: <20101205113311.GC9138@n2100.arm.linux.org.uk>
	<E1PPCrr-0004xW-2c@rmk-PC.arm.linux.org.uk>
Message-ID: <AANLkTim=9biLJAa1=g0TJKCTToaYfk5Tk9EGSjdKp0oR@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 December 2010 11:34, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Every architecture using the GIC has a gic_cpu_base_addr pointer for
> GIC 0 for their entry assembly code to use to decode the cause of the
> current interrupt. ?Move this into the common GIC code.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
