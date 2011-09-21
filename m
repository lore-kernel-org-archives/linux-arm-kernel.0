From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Sep 2011 11:20:51 -0700
Subject: [GIT PULL] OMAP: omap_device cleanup for v3.2
In-Reply-To: <87y5xps6kv.fsf@ti.com>
References: <87mxe5tlzv.fsf@ti.com>
 <87y5xps6kv.fsf@ti.com>
Message-ID: <20110921182051.GH2937@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [110915 16:23]:
> Kevin Hilman <khilman@ti.com> writes:
> 
> > Please pull this omap_device cleanup series for v3.2.  This sets the
> > groundwork for Benoit's DT infrastructure work.
> 
> Turns out this series has a dependency on a patch[1] in Russell's
> for-next branch.
> 
> Russell, any chance of picking this patch into your devel-stable so we
> have a fixed point to merge with?

Or maybe Kevin can add it to his series instead?

Tony
 

> [1]
> commit 456f69c544d4298e921dc0c606492cdbaa60b34b
> Author: Kevin Hilman <khilman@deeprootsystems.com>
> Date:   Tue Sep 6 21:04:10 2011 +0100
> 
>     ARM: 7082/1: platform_device: pdev_archdata: add omap_device pointer
>     
>     Add omap_device pointer to the ARM-specific arch data in the
>     platform_device.  This will be used to attach OMAP-specific
>     device-data to the platform device with device lifetime.
>     
>     Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
>     
>     Acked-by: Grant Likely <grant.likely@secretlab.ca>
>     Signed-off-by: Kevin Hilman <khilman@ti.com>
>     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
