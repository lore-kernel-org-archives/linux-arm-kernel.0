From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Mon, 06 Nov 2017 18:09:41 +0200
Subject: [PATCH v5 4/7] i2c: designware: add i2c gpio recovery option
In-Reply-To: <1509590430-11968-5-git-send-email-preid@electromag.com.au>
References: <1509590430-11968-1-git-send-email-preid@electromag.com.au>
 <1509590430-11968-5-git-send-email-preid@electromag.com.au>
Message-ID: <1509984581.25007.47.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-11-02 at 10:40 +0800, Phil Reid wrote:
> From: Tim Sander <tim@krieglstein.org>
> 
> This patch contains much input from Phil Reid and has been tested
> on Intel/Altera Cyclone V SOC Hardware with Altera GPIO's for the
> SCL and SDA GPIO's.
> 
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Shame on me, I totally forgot one important comment on all this.

How do we switch pinctrl back to the native function? Is it guaranteed
by pinctrl framework and all underneath drivers?


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
