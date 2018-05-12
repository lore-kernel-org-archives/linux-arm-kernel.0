From: songxiaowei@hisilicon.com (songxiaowei)
Date: Sat, 12 May 2018 00:52:56 +0000
Subject: =?gb2312?B?tPC4tDogW1BBVENIIHYzIDIvMl0gYXJtNjQ6IGR0czogaGkzNjYwOiBBZGQg?=
 =?gb2312?Q?pcie_msi_interrupt_attribute?=
In-Reply-To: <5AF5A411.4010507@hisilicon.com>
References: <1526030149-23985-1-git-send-email-chenyao11@huawei.com>
 <1526030149-23985-3-git-send-email-chenyao11@huawei.com>
 <5AF5A411.4010507@hisilicon.com>
Message-ID: <99B4C6BADD9E3241B25E52B02BA737C54127E1D9@DGGEMA505-MBS.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wei,

Thanks a lot.

Xiaowei.

> -----????-----
> ???: xuwei (O)
> ????: 2018?5?11? 22:09
> ???: chenyao (F) <chenyao11@huawei.com>; songxiaowei
> <songxiaowei@hisilicon.com>; Wangbinghui <wangbinghui@hisilicon.com>;
> lorenzo.pieralisi at arm.com; bhelgaas at google.com; robh+dt at kernel.org;
> mark.rutland at arm.com; catalin.marinas at arm.com; will.deacon at arm.com;
> linux-pci at vger.kernel.org; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org
> ??: dimitrysh at google.com; guodong.xu at linaro.org; Suzhuangluan
> <suzhuangluan@hisilicon.com>; Kongfei <kongfei@hisilicon.com>; xuwei (O)
> <xuwei5@huawei.com>
> ??: Re: [PATCH v3 2/2] arm64: dts: hi3660: Add pcie msi interrupt attribute
> 
> Hi Yao,
> 
> On 2018/5/11 10:15, Yao Chen wrote:
> > Add pcie msi interrupt attribute for hi3660 SOC.
> >
> > Signed-off-by: Yao Chen <chenyao11@huawei.com>
> 
> Applied patch 2 into the hisilicon dt tree.
> Thanks!
> 
> BR,
> Wei
> 
> > ---
> >  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > index ec3eb8e..2cef8f4 100644
> > --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > @@ -872,6 +872,8 @@
> >  				  0x0 0x02000000>;
> >  			num-lanes = <1>;
> >  			#interrupt-cells = <1>;
> > +			interrupts = <0 283 4>;
> > +			interrupt-names = "msi";
> >  			interrupt-map-mask = <0xf800 0 0 7>;
> >  			interrupt-map = <0x0 0 0 1
> >  					 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
> >
