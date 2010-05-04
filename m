From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Tue, 04 May 2010 16:21:41 +0300
Subject: [PATCH v2] Add support for Samsung SoC OneNAND controllers
In-Reply-To: <1272469609-21876-1-git-send-email-m.szyprowski@samsung.com>
References: <1272469609-21876-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1272979301.3702.8.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-04-28 at 17:46 +0200, Marek Szyprowski wrote:
> This patch series add support for Samsung SoC OneNAND controllers found
> on S3C64xx, S5PC100 and S5PC110 chips. A few extensions to OneNAND core
> were required to make the driver working properly on all supported SoCs.
> 
> The required platform setup code has been posted to relevant mailing
> list (ARM Kernel: "[PATCH] ARM: Samsung: Add platform support code for
> OneNAND controller" thread).
> 
> Changes since v1:
> * addressed all coding style issues reported by Ben Dooks
> * moved all resource definitions to platform device resources
> * moved all resource definitions for different SoCs from regs-onenand.h to
>   arch/arm/mach-{s3c64xx,s5pc100,s5pv210}/include/mach/map.h
> * moved all #ifdef conditional code to separate functions
> 
> This patch series includes:
> 
> [PATCH 1/5] drivers: mtd: onenand: add support for chips with 4KB page size
> [PATCH 2/5] drivers: mtd: onenand: allocate verify buffer in the core
> [PATCH 3/5] drivers: mtd: onenand: add new callback for bufferram read
> [PATCH 4/5] drivers: mtd: onenand: add workaround for SYNC_WRITE mode
> [PATCH 5/5] drivers: mtd: add Samsung SoC OneNAND driver

Pushed this series to my l2-mtd-2.6.git / dunno

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
