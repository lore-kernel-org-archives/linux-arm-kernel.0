From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 5 Dec 2010 22:07:46 +0000
Subject: [PATCH 5/5] ARM: GIC: private a standard get_irqnr_preamble
	assembler macro
In-Reply-To: <E1PPCsV-0004xe-Ua@rmk-PC.arm.linux.org.uk>
References: <20101205113311.GC9138@n2100.arm.linux.org.uk>
	<E1PPCsV-0004xe-Ua@rmk-PC.arm.linux.org.uk>
Message-ID: <AANLkTikBcgE2R6uO_vYbLqfdbsLULfHczfjAULuEHYpr@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 December 2010 11:35, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Provide a standard get_irqnr_preamble assembler macro for platforms
> to use, which retrieves the base address of the GIC CPU interface
> from gic_cpu_base_addr. ?Allow platforms to override this by defining
> HAVE_GET_IRQNR_PREAMBLE.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
