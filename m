From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Tue, 31 Oct 2017 12:10:46 +0200
Subject: [PATCH v4 3/7] i2c: designware: rename i2c_dw_plat_prepare_clk
 to i2c_dw_prepare_clk
In-Reply-To: <1509435239-64848-4-git-send-email-preid@electromag.com.au>
References: <1509435239-64848-1-git-send-email-preid@electromag.com.au>
 <1509435239-64848-4-git-send-email-preid@electromag.com.au>
Message-ID: <1509444646.10233.103.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-10-31 at 15:33 +0800, Phil Reid wrote:
> For consistency with the reset of the file rename function and 

reset -> rest ?

> parameter to
> be consistent with the reset of the common file.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
