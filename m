From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 10 Jun 2013 11:44:51 +0200
Subject: [PATCH 00/03] ARM: shmobile: Remove legacy memory bits
In-Reply-To: <20130610094638.20803.18484.sendpatchset@w520>
References: <20130610094638.20803.18484.sendpatchset@w520>
Message-ID: <1652096.4LDaIIx18o@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Monday 10 June 2013 18:46:38 Magnus Damm wrote:
> ARM: shmobile: Remove legacy memory bits
> 
> [PATCH 01/03] ARM: shmobile: Enable ARM_PATCH_PHYS_VIRT
> [PATCH 02/03] ARM: shmobile: Remove MEMORY_START/SIZE
> [PATCH 03/03] ARM: shmobile: Remove mach/memory.h
> 
> Now when all users are gone this series removes the legacy memory code
> and enables CONFIG_ARM_PATCH_PHYS_VIRT. Depends on the following code:
> 
> [PATCH v2] ARM: shmobile: uImage load address rework
> [PATCH] ARM: shmobile: Rework sh7372 sleep code to use virt_to_phys()
> [PATCH 00/06] ARM: shmobile: SMP virt_to_phys() conversion
> [PATCH 00/02] ARM: shmobile: romImage update
> 
> The romImage series above still needs to be updated.
> 
> This is the final bit of code not to rely on CONFIG_MEMORY_START/SIZE
> which in turn is one component that we need for ARCH_MULTIPLATFORM.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

I'm very happy to see CONFIG_MEMORY_START|SIZE go, thanks a lot for your work.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
