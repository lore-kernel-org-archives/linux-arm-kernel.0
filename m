From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 04 Sep 2014 10:35:28 +0530
Subject: [RESEND PATCH] arm64: dts: add <dt-bindings/> symlink
In-Reply-To: <20140902084214.GE25379@arm.com>
References: <1409629756-14304-1-git-send-email-pankaj.dubey@samsung.com>
 <20140902084214.GE25379@arm.com>
Message-ID: <002801cfc7fd$d9c5b5a0$8d5120e0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Will Deacon [mailto:will.deacon at arm.com]
> Sent: Tuesday, September 02, 2014 2:12 PM
> To: Pankaj Dubey
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; naushad at samsung.com; Catalin Marinas;
> robh+dt at kernel.org; thomas.ab at samsung.com
> Subject: Re: [RESEND PATCH] arm64: dts: add <dt-bindings/> symlink
> 
> On Tue, Sep 02, 2014 at 04:49:16AM +0100, Pankaj Dubey wrote:
> > Add symlink to include/dt-bindings from arch/arm64/boot/dts/include/
> > to match the ones in ARM architectures so that preprocessed device
> > tree files can include various useful constant definitions.
> >
> > See commit c58299aa8754 ("kbuild: create an "include chroot" for DT
> > bindings") merged in v3.10-rc1 for details.
> >
> > CC: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > ---
> >
> > Resubmitting this change as now it will be required for Samsung ARM64
> > based SoC.
> 
> Just include this change in the series adding a .dts that needs it -- it
doesn't really
> make sense in isolation (unless somebody desperately wants this in?).
> 

OK, we will include this patch in series adding a .dts that needs it in next
respin.

@Naveen: Please include this patch whenever you are respinning Exynos7 dts
patches.

Thanks,
Pankaj Dubey
> Will
