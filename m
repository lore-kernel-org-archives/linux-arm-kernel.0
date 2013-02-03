From: sameo@linux.intel.com (Samuel Ortiz)
Date: Sun, 3 Feb 2013 18:07:18 +0100
Subject: [PATCH 0/4] add ux500_wdt support
In-Reply-To: <1358509214-22407-1-git-send-email-fabio.baltieri@linaro.org>
References: <1358509214-22407-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <20130203170718.GR8476@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Fri, Jan 18, 2013 at 12:40:10PM +0100, Fabio Baltieri wrote:
> Hi all,
> 
> this set adds support for the ux500_wdt timer, implemented in the PRCMU
> unit of ST-Ericsson ux500 architecture.
> 
> The first two patches add the necessary definitions and function export
> to the PRCMU driver currently in mainline, while the third an fourth
> patches add the actual watchdog driver and mfd_cell definition to make
> it probe when PRCMU is compiled in.
> 
> As the patches touches files in both mfd and watchdog subsystems, what do
> you think is the best way to handle this set?
> 
> Thanks,
> Fabio
> 
> 
> Fabio Baltieri (4):
>   mfd: dbx500-prcmu: add watchdog ID definitions
>   mfd: dbx500-prcmu: export a9wdog functions
>   watchdog: add support for ux500_wdt watchdog
>   mfd: db8500-prcmu: add ux500_wdt mfd_cell
All 4 patches (v2 for #3) applied, many thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
