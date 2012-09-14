From: akpm@linux-foundation.org (Andrew Morton)
Date: Fri, 14 Sep 2012 12:51:06 -0700
Subject: [PATCH v2 0/4] lis3: lis3lv02d_i2c: Add device tree support
In-Reply-To: <201209141531.36734.arnd@arndb.de>
References: <1347610016-10123-1-git-send-email-anilkumar@ti.com>
 <201209141531.36734.arnd@arndb.de>
Message-ID: <20120914125106.ae809500.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Sep 2012 15:31:36 +0000
Arnd Bergmann <arnd@arndb.de> wrote:

> On Friday 14 September 2012, AnilKumar Ch wrote:
> > Adds device tree support to lis3lv02d_i2c driver. Along with this
> > DT init is moved from core driver to individual drivers, with the
> > current implementation some pdata is missing in lis3lv02d_i2c driver.
> > 
> > Also adds platform data for lis331dlh driver to am335x-EVM. These
> > patches were tested on AM335x-EVM.
> > 
> 
> No further comments on this version besides the ones I already gave
> on v1.

My linux-arm-kernel subscription died so I don't know what your v1
comments said.  Were they fatal?
