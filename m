From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 20 Dec 2017 13:08:39 +0000
Subject: [PATCH v1] mfd: ab8500: introduce DEFINE_SHOW_ATTRIBUTE() macro
In-Reply-To: <20171214105121.77015-1-andriy.shevchenko@linux.intel.com>
References: <20171214105121.77015-1-andriy.shevchenko@linux.intel.com>
Message-ID: <20171220130839.lqfxhowwx6rsqaob@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Dec 2017, Andy Shevchenko wrote:

> This macro deduplicates a lot of similar code in the ab8500-debugfs.c module.
> Targeting to be moved to seq_file.h eventually.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/ab8500-debugfs.c | 406 +++++++------------------------------------
>  1 file changed, 62 insertions(+), 344 deletions(-)

Applied, thanks.

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
