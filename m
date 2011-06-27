From: Baohua.Song@csr.com (Baohua Song)
Date: Mon, 27 Jun 2011 03:05:32 +0000
Subject: [PATCH] INPUT:Add ABS_PRESSURE input event support for
	touchscreen driver
In-Reply-To: <BANLkTi=O44wyaFB_B83LGiQhAVtFOp64pyhMaCKCf_YZz6b1GA@mail.gmail.com>
References: <1308881738-6392-1-git-send-email-wdgvip@gmail.com>
	<20110624124154.GC19804@sirena.org.uk>
	<BANLkTi=O44wyaFB_B83LGiQhAVtFOp64pyhMaCKCf_YZz6b1GA@mail.gmail.com>
Message-ID: <5EB3BFCD089AD643B9BB63439F5FD5E937BB882D@SHAASIEXM01.ASIA.ROOT.PRI>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org
> [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of daoguang
> wu
> Sent: 2011?6?27? 10:15
> To: Mark Brown
> Cc: kgene.kim at samsung.com; ben-linux at fluff.org;
> dmitry.torokhov at gmail.com; linux-kernel at vger.kernel.org;
> wdgvip at gamil.com; linux-input at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] INPUT:Add ABS_PRESSURE input event support for
> touchscreen driver
> 
> 2011/6/24 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> > On Fri, Jun 24, 2011 at 10:15:38AM +0800, Wu DaoGuang wrote:
> >> The touchscreen driver s3c2410_ts.c doesn't work well when using
> >> the tslib, an abstraction layer for touchscreen panel events.
> >> Tslib needs ABS_X ABS_Y and ABS_PRESSURE events to report, but only
> >> the former two the driver can provide.
> >
> > It seems much more sane to fix this in tslib, the kernel is not actually
> > reporting pressure meaningfully here and there's already BTN_TOUCH to
> > report if the pen is down.
> >
> yeah,I will try to fix it in tslib.

You may send a patch to tslib. 

> Thanks a lot.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
>  To report this email as spam click
> https://www.mailcontrol.com/sr/wQw0zmjPoHdJTZGyOCrrhg==
> t4zoc+!n!INSV2C4qhUHSr1YUlPAL0C6yBmfTIRMbBnxawg== .


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
