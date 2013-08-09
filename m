From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 9 Aug 2013 03:47:02 +0000 (UTC)
Subject: [PATCH] ARM: OMAP4: clock: Lock PLLs in the right sequence
In-Reply-To: <20130809011820.5348.78407@quantum>
References: <1375956851-842-1-git-send-email-rnayak@ti.com>
 <20130809011820.5348.78407@quantum>
Message-ID: <alpine.DEB.2.02.1308090345340.32157@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Thu, 8 Aug 2013, Mike Turquette wrote:

> Quoting Rajendra Nayak (2013-08-08 03:14:11)
> > On OMAP4 we have clk_set_rate()s being done for a few
> > DPLL clock nodes, as part of the clock init code, since
> > the bootloaders no longer locks these DPLLs.
> ...
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> 
> Taken into clk-next. Thanks for the fix. Besides the annoying prints is
> there a functional regression fixed by this? If so I can take into
> clk-fixes as needed.

It's best if I take this patch upstream.  That way, potential merge 
conflicts are avoided, since I might have other changes to 
arch/arm/mach-omap2/cclock44xx_data.c to send upstream at the same time.


- Paul
