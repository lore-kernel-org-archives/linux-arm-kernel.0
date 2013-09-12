From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Thu, 12 Sep 2013 17:05:06 +0300
Subject: [PATCH 1/2] ARM: msm: Add support for MSM8974 Dragonboard
In-Reply-To: <20130911180006.GA12624@codeaurora.org>
References: <1375743779-24993-1-git-send-email-rvaswani@codeaurora.org>
 <1375780486.2725.7.camel@iivanov-dev.int.mm-sol.com>
 <20130911180006.GA12624@codeaurora.org>
Message-ID: <1378994706.16481.6.camel@iivanov-dev.int.mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2013-09-11 at 11:00 -0700, David Brown wrote: 
> On Tue, Aug 06, 2013 at 12:14:46PM +0300, Ivan T. Ivanov wrote:
> 
> >Attached patch enables earlyprink for this board.
> >
> >[920] booting linux @ 0x8000, ramdisk @ 0x2000000 (1067699), tags/device tree @ 0x1e00000
> >Uncompressing Linux... done, booting the kernel.
> >[    0.000000] Booting Linux on physical CPU 0x0
> >[    0.000000] Linux version 3.11.0-rc4-00003-g7c8394e (iivanov at dev) (gcc version 4.6.3 (GCC) ) #502 SMP PREEMPT Tue Aug 6 12:09:07 EEST3
> >[    0.000000] CPU: ARMv7 Processor [512f06f0] revision 0 (ARMv7), cr=10c5387d
> >[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
> >[    0.000000] Machine: Qualcomm MSM (Flattened Device Tree), model: Qualcomm MSM8974 Dragonboard
> 
> We'll need to have either Rohit include this in his patch series, or
> you'll have to format this as a valid patch.

I don't have preferences. Rohit could you send this patch 
with you changes?

Regards,
Ivan

> 
> Thanks,
> David
> 
