From: marex@denx.de (Marek Vasut)
Date: Tue, 2 Apr 2013 21:11:05 +0200
Subject: [PATCH] ARM: mxs: Slow down the I2C clock speed
In-Reply-To: <20130402112850.GD24039@S2101-09.ap.freescale.net>
References: <1364858969-17745-1-git-send-email-marex@denx.de>
 <20130402112850.GD24039@S2101-09.ap.freescale.net>
Message-ID: <201304022111.05858.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> Marek,
> 
> On Tue, Apr 02, 2013 at 01:29:29AM +0200, Marek Vasut wrote:
> > Slow down the I2C clock speed on M28 and SPS1 as it turns out the
> > I2C block in i.MX28 can not operate stable enough with the bus
> > running at 400kHz. Note that the driver used by Freescale runs
> > the bus at 250kHz when 400kHz speed is selected, but the mainline
> > Linux kernel runs the bus at actual 400kHz and that's where it is
> > occasionally unstable. Play safe and run the bus at 100kHz.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> 
> You consider it a fix for 3.9 or just material for 3.10?

Fix for 3.9 please.

Best regards,
Marek Vasut
