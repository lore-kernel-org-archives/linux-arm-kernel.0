From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Sep 2012 11:51:07 +0000
Subject: [PATCH v3 0/4] lis3: lis3lv02d_i2c: Add device tree support
In-Reply-To: <1347866602-2088-1-git-send-email-anilkumar@ti.com>
References: <1347866602-2088-1-git-send-email-anilkumar@ti.com>
Message-ID: <201209171151.07462.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 September 2012, AnilKumar Ch wrote:
> Adds device tree support to lis3lv02d_i2c driver. Along with this
> DT init is moved from core driver to individual drivers, with the
> current implementation some pdata is missing in lis3lv02d_i2c driver.
> 
> Also adds platform data for lis331dlh driver to am335x-EVM. These
> patches were tested on AM335x-EVM.

Looks good to me.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
