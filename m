From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Thu, 2 Jul 2015 07:24:40 +0000
Subject: [PATCH v3 2/5] PCI: designware: Add ARM64 support
In-Reply-To: <55942441.3050705@arm.com>
References: <1435743817-19083-1-git-send-email-wangzhou1@hisilicon.com>
 <1435743817-19083-3-git-send-email-wangzhou1@hisilicon.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E01D4E4BB@lhreml503-mbs>
 <5593F899.6050306@arm.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E01D4E6A2@lhreml503-mbs>
 <55942441.3050705@arm.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E01D4EC38@lhreml503-mbs>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-pci-owner at vger.kernel.org [mailto:linux-pci-
> owner at vger.kernel.org] On Behalf Of James Morse
> Sent: 01 July 2015 18:33
> To: Gabriele Paoloni; Wangzhou (B); Bjorn Helgaas; Jingoo Han; Pratyush
> Anand; Arnd Bergmann; Liviu Dudau; kishon at ti.com; xobs at kosagi.com; m-
> karicheri2 at ti.com; Minghuan.Lian at freescale.com
> Cc: linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; Yuanzhichang; Zhudacai; zhangjukuo;
> qiuzhenfa; Liguozhu (Kenneth)
> Subject: Re: [PATCH v3 2/5] PCI: designware: Add ARM64 support
> 
> Gabriele Paoloni wrote:
> >> Both series are applied to v4.1, use the same .config file, and the
> >> same dtb.
> >> I will investigate further.
> >>
> >> (Re-testing v2 works, so this isn't an interim hardware failure)
> >
> > This is a bit weird....
> >
> > Patch 2/5 is the only one that affect platforms different from
> Hisilicon
> >
> > The only difference between V3 patch[2/5] and v2 patch[2/4] is
> 
> Between v3:2/5 and your replacement for v2:2/4, which arrived after I
> had
> tested the v2 series. As the patch has been replaced with a different
> one -
> neither 'tested-by' is true any more.

Sorry I misread your previous email

> 
> It looks like the BAR containing the bridge window is not being assigned,
> so no devices on bus 1 are discovered.

Can you confirm the dtsi you are using..."imx6qdl.dtsi" ?

Thanks

Gab

> 
> I will send the full v2 and v3 dmesg output separately.
> 
> 
> Thanks,
> 
> James
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
