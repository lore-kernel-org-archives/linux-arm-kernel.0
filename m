From: tony@atomide.com (Tony Lindgren)
Date: Fri, 11 May 2012 13:11:13 -0700
Subject: [PATCH 00/13] ARM: OMAP5: Add minimal OMAP5 SOC support
In-Reply-To: <e02393fc87c4e06ce1d783a03747aff7@mail.gmail.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <e02393fc87c4e06ce1d783a03747aff7@mail.gmail.com>
Message-ID: <20120511201113.GA21851@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Sricharan R <r.sricharan@ti.com> [120510 10:47]:
> Hi Tony,
> 
> > -----Original Message-----
> > From: R Sricharan [mailto:r.sricharan at ti.com]
> > Sent: Thursday, May 03, 2012 12:56 PM
> > To: linux-omap at vger.kernel.org
> > Cc: linux-arm-kernel at lists.infradead.org; santosh.shilimkar at ti.com;
> > tony at atomide.com; b-cousson at ti.com; r.sricharan at ti.com
> > Subject: [PATCH 00/13] ARM: OMAP5: Add minimal OMAP5 SOC support
> >
> > The series adds minimal OMAP5 support.
> > OMAP5430 has a dual core Cortex-A15 based MPU subsystem with 2MB
> > L2 cache. The SOC has many compatible blocks with OMAP4 SOCS and
> > hence large part of the peripherals are re-used.
> >
> > OMAP5432 is another variant of OMAP5430, with a
> > memory controller supporting DDR3 and SATA.
> >
>  OMAP5 V2 series is ready with all comments addressed, but I have
>  below dependencies to be merged to apply my series against your
>  cleanup-soc branch

OK
 
>  1) git://git.pwsan.com/linux-2.6 hwmod_soc_conditional_cleanup_3.5

This one is not merged in yet and it seems that we're out of time
for v3.5 unless it drags on and we have -rc8 after -rc7.

>  2) git://git.pwsan.com/linux-2.6 hwmod_data_cleanup_3.5
>  3) https://github.com/hvaibhav/am335x-linux   32ksync-timer-cleanup

These two are merged in arm-soc now.

>  4) http://www.spinics.net/lists/arm-kernel/msg174461.html

I think this series still has some pending comments?
 
>  Can you please let me know how you want me to prepare the series
>  with these dependencies.

Until these dependencies get cleared out, it seems that the best
branch to base your patches is omap-cleanup-timer-for-v3.5 tag
and just carry the pending patches for a little bit longer.

Regards,

Tony
