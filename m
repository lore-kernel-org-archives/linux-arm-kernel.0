From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Sep 2012 15:31:36 +0000
Subject: [PATCH v2 0/4] lis3: lis3lv02d_i2c: Add device tree support
In-Reply-To: <1347610016-10123-1-git-send-email-anilkumar@ti.com>
References: <1347610016-10123-1-git-send-email-anilkumar@ti.com>
Message-ID: <201209141531.36734.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 September 2012, AnilKumar Ch wrote:
> Adds device tree support to lis3lv02d_i2c driver. Along with this
> DT init is moved from core driver to individual drivers, with the
> current implementation some pdata is missing in lis3lv02d_i2c driver.
> 
> Also adds platform data for lis331dlh driver to am335x-EVM. These
> patches were tested on AM335x-EVM.
> 

No further comments on this version besides the ones I already gave
on v1.

	Arnd
