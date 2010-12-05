From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 5 Dec 2010 22:04:24 +0000
Subject: [PATCH 4/5] ARM: GIC: move gic_data[] initialization into
	gic_init()
In-Reply-To: <E1PPCsB-0004xa-H0@rmk-PC.arm.linux.org.uk>
References: <20101205113311.GC9138@n2100.arm.linux.org.uk>
	<E1PPCsB-0004xa-H0@rmk-PC.arm.linux.org.uk>
Message-ID: <AANLkTim_+9DJYA4R+HvT4pNT5cp21i6bvaRhLmJV2AQ8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 December 2010 11:35, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> This avoids writing unnecessarily to gic_data[] from other CPUs,
> making this a mostly read-only variable.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
