From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 1 Aug 2012 12:50:12 +0800
Subject: [06/10,V2] spi: Add SPI driver for mx233/mx28
In-Reply-To: <20120801033559.GB2323@roeck-us.net>
References: <1341555449-17507-6-git-send-email-marex@denx.de>
 <20120731205300.GA25721@roeck-us.net>
 <201208010431.04399.marex@denx.de>
 <20120801035333.GB1672@S2100-06.ap.freescale.net>
 <20120801033559.GB2323@roeck-us.net>
Message-ID: <20120801045010.GC1672@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 08:35:59PM -0700, Guenter Roeck wrote:
> I think the call to spi_master_put() triggers the call to spi_master_release().
> If so, kfree() would not be needed at all, and the documentation is wrong.
> 
Also those drivers calling kfree in probe.

Regards,
Shawn
