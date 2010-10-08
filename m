From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 08 Oct 2010 18:52:57 +0900
Subject: [PATCH v2 0/6] ARM: S5PV210: Add support S5PV210/S5PC110 CPUFREQ
In-Reply-To: <004001cb6605$01ff4f90$05fdeeb0$@com>
References: <1284962695-8542-1-git-send-email-sbkim73@samsung.com>
	<004001cb6605$01ff4f90$05fdeeb0$@com>
Message-ID: <001501cb66ce$9dc54b40$d94fe1c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sangbeom Kim wrote:
> 
> Hi all,
> I know that there is another S5PV210 CPUFREQ patch from Mr. Ham.
> But, That patchset seems to have unclear part.
>
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-August/023626.htm
> l
> The part of 'CONFIG_PM' is unclear and still have PM support part.
> So, I think that this patch is more suitable for S5PV210/S5PC110 CPUFREQ
in
> the mainline.
> because this patch implemented basic pm functionality and already tested
on
> smdkv210 board.
> 
Hi,

So...I'd like to merge this for this merge window.

Mr. Ham, how do you think?
If any problems or opinions, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> Thanks and regards,
> S.B. Kim
> 
> > on Monday, September 20, 2010 3:05 PM, Sangbeom Kim
> <sbkim73@samsung.com>
> wrote:
> >
> > This patch adds CPUFREQ for S5PV210/S5PC110.
> >
> > Changes since v1:
> >
> > - Added MOUT_DMC0 and SCLK_DMC0 for checking the dmc0 clock in
> CPUFREQ
> > driver.
> > - Removed hardcoding of DRAM refresh counter.
> > - Added to calculate refresh counter function based on DRAM operation
> freq.
> >
> > [PATCH v2 1/6] ARM: S5PV210: Add DMC map_desc table for supporting DMC
> > access
> > [PATCH v2 2/6] ARM: S5PV210: Add struct clk_ops for clk_fout_apll
> > [PATCH v2 3/6] ARM: S5PV210: Add MOUT_DMC0 and SCLK_DMC0 clocks
> > [PATCH v2 4/6] ARM: S5PV210: Add Register definition for CMU
> > [PATCH v2 5/6] ARM: S5PV210: Add support CPUFREQ
> > [PATCH v2 6/6] ARM: S5PV210: Update Kconfig and Makefile for supporting
> > CPUFREQ driver
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-samsung-
> > soc" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
