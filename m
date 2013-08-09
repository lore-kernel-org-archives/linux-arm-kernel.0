From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 08 Aug 2013 22:35:34 -0700
Subject: [PATCH] ARM: OMAP4: clock: Lock PLLs in the right sequence
In-Reply-To: <alpine.DEB.2.02.1308090345340.32157@utopia.booyaka.com>
References: <1375956851-842-1-git-send-email-rnayak@ti.com>
 <20130809011820.5348.78407@quantum>
 <alpine.DEB.2.02.1308090345340.32157@utopia.booyaka.com>
Message-ID: <20130809053534.5348.29850@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Paul Walmsley (2013-08-08 20:47:02)
> Hi Mike,
> 
> On Thu, 8 Aug 2013, Mike Turquette wrote:
> 
> > Quoting Rajendra Nayak (2013-08-08 03:14:11)
> > > On OMAP4 we have clk_set_rate()s being done for a few
> > > DPLL clock nodes, as part of the clock init code, since
> > > the bootloaders no longer locks these DPLLs.
> > ...
> > > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > 
> > Taken into clk-next. Thanks for the fix. Besides the annoying prints is
> > there a functional regression fixed by this? If so I can take into
> > clk-fixes as needed.
> 
> It's best if I take this patch upstream.  That way, potential merge 
> conflicts are avoided, since I might have other changes to 
> arch/arm/mach-omap2/cclock44xx_data.c to send upstream at the same time.

No problem. I had not yet published it to clk-next so this causes no
issue.

Regards,
Mike

> 
> 
> - Paul
