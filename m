From: myungjoo.ham@samsung.com (=?UTF-8?B?TXl1bmdKb28gSGFt?=)
Date: Thu, 20 Oct 2016 02:31:17 +0000
Subject: =?UTF-8?B?Rlc6IFJFOiBbUEFUQ0ggMC80XSBQTSAvIGRldmZyZXE6IEZp?=
 =?UTF-8?B?eCBtb2R1bGUgYXV0b2xvYWQgZm9yIHBsYXRmb3JtIGRyaXZl?= =?UTF-8?B?cnM=?=
References: <CGME20161019210645epcas1p449463edf9c3cb3681b0a4e8116ccf7f2@epcas1p4.samsung.com>
Message-ID: <1458141592.1463929.1476930677746.JavaMail.weblogic@ep1ml101a>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Hello,
> > 
> > I noticed that module autoload won't be working in some of the defreq
> > platform drivers. This patch series contains the fixes for these.
> > 
> > Best regards,
> > Javier
> > 
> > 
> > Javier Martinez Canillas (4):
> >   PM / devfreq: rk3399_dmc: Fix module autoload
> >   PM / devfreq: exynos-nocp: Fix module autoload
> >   PM / devfreq: rockchip-dfi: Fix module autoload
> >   PM / devfreq: exynos-ppmu: Fix module autoload
> 
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> 
> All the four are not at for-4.9-rc branch.

not --> now

> https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/log/?h=for-4.9-rc
> 
> 
> Cheers,
> MyungJoo
> 
> > 
> >  drivers/devfreq/event/exynos-nocp.c  | 1 +
> >  drivers/devfreq/event/exynos-ppmu.c  | 1 +
> >  drivers/devfreq/event/rockchip-dfi.c | 1 +
> >  drivers/devfreq/rk3399_dmc.c         | 1 +
> >  4 files changed, 4 insertions(+)
> > 
> > -- 
> > 2.7.4
