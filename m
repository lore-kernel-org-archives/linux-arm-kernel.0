From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Tue, 19 Dec 2017 16:50:37 +0200
Subject: [PATCH v1] mfd: ab8500: introduce DEFINE_SHOW_ATTRIBUTE() macro
In-Reply-To: <20171215105432.pm36mtles7mpvcye@dell>
References: <20171214105121.77015-1-andriy.shevchenko@linux.intel.com>
 <20171215105432.pm36mtles7mpvcye@dell>
Message-ID: <1513695037.7000.194.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-12-15 at 10:54 +0000, Lee Jones wrote:
> Linus,
> 

I suppose you would like to get his attention :-)

> > This macro deduplicates a lot of similar code in the ab8500-
> > debugfs.c module.
> > Targeting to be moved to seq_file.h eventually.
> > 

Linus, it would be nice to have this in three for this cycle that will
allow me to move it to seq_file.h in the next one.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
