From: mugunthanvnm@ti.com (N, Mugunthan V)
Date: Tue, 9 Oct 2012 16:27:03 +0000
Subject: Booting vanilla kernel on the beaglebone
In-Reply-To: <50740AB0.7080102@ti.com>
References: <20120930082802.GA15392@netboy.at.omicron.at>
 <50740AB0.7080102@ti.com>
Message-ID: <EB1619762EAF8B4E97A227FB77B7E0293E9F27CE@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -------- Original Message --------
> Subject: Booting vanilla kernel on the beaglebone
> Date: Sun, 30 Sep 2012 10:28:02 +0200
> From: Richard Cochran <richardcochran@gmail.com>
> To: <linux-arm-kernel@lists.infradead.org>
> 
> 
> I just received by very own beaglebone, and I would like to add PTP
> hardware clock support for the CPTS unit, but I naturally want to do
> this with the latest mainstream kernel and not the hacked up arago 3.2
> kernel that ships with the board.
> 
> Does any vanilla kernel even boot on this board?
> If so, which ones, and how?
> 
> I have tried a few variations of kernel/u-boot without any luck.
> The u-boot that came with the board is
> 
>   U-Boot 2011.09-00000-gf63b270-dirty (Apr 24 2012 - 09:51:01)
>   arm-angstrom-linux-gnueabi-gcc (GCC) 4.5.4 20120305 (prerelease)
>   GNU ld (GNU Binutils) 2.20.1.20100303
> 
> and I also tried the latest version:
> 
>   U-Boot 2012.10-rc1-00148-g4668a08 (Sep 30 2012 - 09:35:20)
>   arm-none-linux-gnueabi-gcc (Sourcery G++ Lite 2009q1-203) 4.3.3
>   GNU ld (Sourcery G++ Lite 2009q1-203) 2.19.51.20090205
> 

Richard

I have implemented the CPTS hardware clock and will be submitting the
patches soon to TI's kernel repo and also planning to submit the patches
to Mainline kernel mailing lists soon.

Regards
Mugunthan V N

> Thanks,
> Richard
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
