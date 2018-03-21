From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Wed, 21 Mar 2018 22:30:00 +0200
Subject: [PATCH v3 3/3] pinctrl: qcom: Don't allow protected pins to be
 requested
In-Reply-To: <152166267662.91116.8188392814465278915@swboyd.mtv.corp.google.com>
References: <20180321165848.89751-1-swboyd@chromium.org>
 <20180321165848.89751-4-swboyd@chromium.org>
 <1521655629.23017.84.camel@linux.intel.com>
 <152166267662.91116.8188392814465278915@swboyd.mtv.corp.google.com>
Message-ID: <1521664200.23017.90.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-03-21 at 13:04 -0700, Stephen Boyd wrote:
> Quoting Andy Shevchenko (2018-03-21 11:07:09)
> > On Wed, 2018-03-21 at 09:58 -0700, Stephen Boyd wrote:
> > > 

> Or ternary?
> 
>   return gpiochip_line_is_valid(chip, offset) ? 0 : -EINVAL;

Fine with me!

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
