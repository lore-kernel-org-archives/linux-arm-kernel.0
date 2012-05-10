From: r.sricharan@ti.com (Sricharan R)
Date: Thu, 10 May 2012 23:13:16 +0530
Subject: [PATCH 00/13] ARM: OMAP5: Add minimal OMAP5 SOC support
In-Reply-To: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
Message-ID: <e02393fc87c4e06ce1d783a03747aff7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

> -----Original Message-----
> From: R Sricharan [mailto:r.sricharan at ti.com]
> Sent: Thursday, May 03, 2012 12:56 PM
> To: linux-omap at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org; santosh.shilimkar at ti.com;
> tony at atomide.com; b-cousson at ti.com; r.sricharan at ti.com
> Subject: [PATCH 00/13] ARM: OMAP5: Add minimal OMAP5 SOC support
>
> The series adds minimal OMAP5 support.
> OMAP5430 has a dual core Cortex-A15 based MPU subsystem with 2MB
> L2 cache. The SOC has many compatible blocks with OMAP4 SOCS and
> hence large part of the peripherals are re-used.
>
> OMAP5432 is another variant of OMAP5430, with a
> memory controller supporting DDR3 and SATA.
>
 OMAP5 V2 series is ready with all comments addressed, but I have
 below dependencies to be merged to apply my series against your
 cleanup-soc branch

 1) git://git.pwsan.com/linux-2.6 hwmod_soc_conditional_cleanup_3.5
 2) git://git.pwsan.com/linux-2.6 hwmod_data_cleanup_3.5
 3) https://github.com/hvaibhav/am335x-linux   32ksync-timer-cleanup
 4) http://www.spinics.net/lists/arm-kernel/msg174461.html

 Can you please let me know how you want me to prepare the series
 with these dependencies.

Thanks,
 Sricharan
