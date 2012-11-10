From: mturquette@ti.com (Mike Turquette)
Date: Fri, 9 Nov 2012 17:07:50 -0800
Subject: [PATCH 0/5] clk: ux500: Add clock lookups for u8500
In-Reply-To: <20121025075138.GD971@gmail.com>
References: <1350914281-1332-1-git-send-email-ulf.hansson@stericsson.com>
 <20121025075138.GD971@gmail.com>
Message-ID: <20121110010750.17381.1960@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Lee Jones (2012-10-25 00:51:38)
> On Mon, 22 Oct 2012, Ulf Hansson wrote:
> 
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > 
> > Step by step, clock lookups for u8500 are being added in this set
> > of patches.
> > 
> > These patches will require additional patches for sound/soc/ux500/
> > driver as well as drivers/i2c/busses/i2c-nomadik driver to prevent
> > the boot for ux500 from break. Those patches are being merged through
> > separate trees.
> > 
> > Ulf Hansson (5):
> >   clk: ux500: Register i2c clock lookups for u8500
> >   clk: ux500: Register ssp clock lookups for u8500
> >   clk: ux500: Register msp clock lookups for u8500
> >   clk: ux500: Update rtc clock lookup for u8500
> >   clk: ux500: Register slimbus clock lookups for u8500
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>
> 
> Can I also mention that these need to go into the -rcs at the
> earliest opportunity please, as it is preventing ~50% of the
> devices from functioning on all of the ST-Ericsson development
> boards. 
> 
> This is a massive blocker for us!
> 

I've taken these patches into clk-next.  Do you need them in as a late
fix in the 3.7 cycle or is your urgent need only for 3.8 development?

Regards,
Mike

> -- 
> Lee Jones
> Linaro ST-Ericsson Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
