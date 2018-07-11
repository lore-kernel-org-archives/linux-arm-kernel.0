From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Wed, 11 Jul 2018 14:31:03 +0300
Subject: [PATCH v5 3/3] serial: 8250_dw: add fractional divisor support
In-Reply-To: <20180711151111.6f417020@xhacker.debian>
References: <20180710110942.5b0a016e@xhacker.debian>
 <20180710111516.13b8c570@xhacker.debian>
 <20180711151111.6f417020@xhacker.debian>
Message-ID: <2b363dc2f8ddd6fe52ba6f7c461b4dd55cfb8bce.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-07-11 at 15:11 +0800, Jisheng Zhang wrote:
> For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
> valid divisor latch fraction register. The fractional divisor width is
> 4bits ~ 6bits.
> 
> Now the preparation is done, it's easy to add the feature support.
> This patch firstly tries to get the fractional divisor width during
> probe, then setups dw specific get_divisor() and set_divisor() hook.
> 

You would need to resend entire series as v6.
Don't forget to add given tags.

But, wait a bit, I would like to check the algo (thanks for C program!).

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
