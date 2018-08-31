From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Fri, 31 Aug 2018 21:23:28 +0300
Subject: [PATCH v5 0/2] clk: Add functions to get optional clocks
In-Reply-To: <1535724443-21150-1-git-send-email-phil.edworthy@renesas.com>
References: <1535724443-21150-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <20180831182328.GF11447@smile.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2018 at 03:07:21PM +0100, Phil Edworthy wrote:
> Quite a few drivers get an optional clock, e.g. a bus clock required to 
> access peripheral's registers that is always enabled on some devices.
> 

Looks good to me

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Perhaps, you may convert 8250_dw to this one later on as an example...

> Phil Edworthy (2):
>   clk: Add of_clk_get_by_name_optional() function
>   clk: Add functions to get optional clocks
> 
>  drivers/clk/clk-devres.c | 18 ++++++++++--
>  drivers/clk/clkdev.c     | 74 ++++++++++++++++++++++++++++++++++++++----------
>  include/linux/clk.h      | 35 +++++++++++++++++++++++
>  3 files changed, 110 insertions(+), 17 deletions(-)
> 
> -- 
> 2.7.4
> 

-- 
With Best Regards,
Andy Shevchenko
