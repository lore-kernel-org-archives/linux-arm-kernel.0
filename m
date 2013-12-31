From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Dec 2013 11:23:02 +0000
Subject: Regression (ARM) arch/arm/mm/init.c doesn't build without
 CONFIG_ARM_PATCH_PHYS_VIRT.
In-Reply-To: <m38uv1uuzr.fsf@t19.piap.pl>
References: <m38uv1uuzr.fsf@t19.piap.pl>
Message-ID: <20131231112301.GC16456@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 31, 2013 at 12:20:56PM +0100, Krzysztof Ha?asa wrote:
> arch/arm/mm/init.c: In function 'setup_dma_zone':
> arch/arm/mm/init.c:232:19: error: '__pv_phys_offset' undeclared (first use in this function)
> 
> Reverting the following commit fixes it:

Already fixed long before Christmas.  Please use recent kernels.
