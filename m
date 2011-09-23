From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 23 Sep 2011 10:28:11 -0700
Subject: [RFC PATCH 07/14] ARM: tegra2: convert to CONFIG_MULTI_IRQ_HANDLER
In-Reply-To: <1316796692-15964-8-git-send-email-marc.zyngier@arm.com>
References: <1316796692-15964-1-git-send-email-marc.zyngier@arm.com>
	<1316796692-15964-8-git-send-email-marc.zyngier@arm.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1739554F81@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Zyngier wrote at Friday, September 23, 2011 10:51 AM:
> Convert the tegra2 platforms to be using the gic_handle_irq
> function as their primary interrupt handler.
> 
> Tested on harmony.
> 
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Colin Cross <ccross@android.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

I'm not experienced in this area of the kernel, but I traced through the
old assembly and new C code, and they appear to be doing the same thing,
and be hooked together sanely, so:

Acked-by: Stephen Warren <swarren@nvidia.com>

-- 
nvpublic
