From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 24 Nov 2012 11:10:32 +0900
Subject: [PATCH V3 0/5] Avoid passing clks through platform data
In-Reply-To: <000101cdc95c$c2575550$4705fff0$@com>
References: <1352177317-16395-1-git-send-email-padma.v@samsung.com>
 <000101cdc95c$c2575550$4705fff0$@com>
Message-ID: <122801cdc9e8$e1f703b0$a5e50b10$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sangbeom Kim wrote:
> 
> On Tue, Nov 6, 2012 at 1:49 PM, Padmavathi Venna wrote:
> 
> > I2S controller has an internal mux for RCLK source clks. The list
> > of source clk names were passed through platform data in non-dt case.
> > The variable holding the list of RCLK source clk names is not
> > required, as the list of clks need to be registered with clkdev
> > using generic connection id. This is required as part of adding DT
> > support for I2S controller driver.
> >
> > In the below series of patches, registered the existed clks with
> > clkdev using generic connection id and removed the variable which
> > holds those clk names. This is done for s3c64xx,s5pc100,s5p64x0,
> > s5pv210 and exynos4 series. But tested the sound card detection
> > only on smdk6410 board. On remaining all platforms it was just
> > build tested.
> >
> > Padmavathi Venna (5):
> >   ARM: S3C64XX: Add I2S clkdev support
> >   ARM: S5PC100: Add I2S clkdev support
> >   ARM: S5P64x0: Add I2S clkdev support
> >   ARM: S5PV210: Avoid passing the clks through platform data
> >   ARM: Exynos: Avoid passing the clks through platform data
> 
> As I2S driver is changed for support DT,
> These patch series should be applied.
> Adding ack all patches.
> 
> Acked-by: Sangbeom Kim <sbkim73@samsung.com>
> 
Looks OK to me, will apply, thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
