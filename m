From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Wed, 29 Aug 2018 20:11:21 +0300
Subject: [PATCH v4 0/2] clk: Add functions to get optional clocks
In-Reply-To: <1533039060-18779-1-git-send-email-phil.edworthy@renesas.com>
References: <1533039060-18779-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <20180829171121.GE11447@smile.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 01:10:58PM +0100, Phil Edworthy wrote:
> Quite a few drivers get an optional clock, e.g. a bus clock required to 
> access peripheral's registers that is always enabled on some devices.
> 

Didn't see any updates so far.
Anyway, this one LGTM,

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Phil Edworthy (2):
>   clk: Add of_clk_get_by_name_optional() function
>   clk: Add functions to get optional clocks
> 
>  drivers/clk/clk-devres.c | 18 +++++++++++++--
>  drivers/clk/clkdev.c     | 58 +++++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/clk.h      | 35 +++++++++++++++++++++++++++++
>  3 files changed, 104 insertions(+), 7 deletions(-)
> 
> -- 
> 2.7.4
> 

-- 
With Best Regards,
Andy Shevchenko
