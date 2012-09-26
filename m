From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 26 Sep 2012 13:24:00 -0700
Subject: [PATCH v3 0/4] lis3: lis3lv02d_i2c: Add device tree support
In-Reply-To: <1347866602-2088-1-git-send-email-anilkumar@ti.com>
References: <1347866602-2088-1-git-send-email-anilkumar@ti.com>
Message-ID: <20120926202400.GA27830@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 12:53:18PM +0530, AnilKumar Ch wrote:
> Adds device tree support to lis3lv02d_i2c driver. Along with this
> DT init is moved from core driver to individual drivers, with the
> current implementation some pdata is missing in lis3lv02d_i2c driver.
> 
> Also adds platform data for lis331dlh driver to am335x-EVM. These
> patches were tested on AM335x-EVM.

None of these patches apply to any tree that I know of, what did you do
them against?  Please redo them against the char-next branch of
linux-next and resend them if you wish to see them applied.

thanks,

greg k-h
