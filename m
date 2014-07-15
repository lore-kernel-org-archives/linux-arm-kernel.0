From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 15 Jul 2014 20:11:37 +0000 (UTC)
Subject: [PATCH 00/13] ARM: OMAP2+: clock cleanup series for 3.17
In-Reply-To: <20140713135331.9850.5226@quantum>
References: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
 <20140713135331.9850.5226@quantum>
Message-ID: <alpine.DEB.2.02.1407152011150.21432@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 13 Jul 2014, Mike Turquette wrote:

> Quoting Tero Kristo (2014-07-02 01:47:34)
> > Hi,
> > 
> > This sets cleans up some of the omap specific clock drivers still residing
> > under arch/arm/mach-omap2. This set is done in preparation to migrate
> > these drivers eventually under drivers/clk/ti, where we don't have access
> > to certain board specific functionality. The basic idea of this set is to
> > introduce clk_features struct which contains any SoC specific data / flags
> > within it, and this is used runtime instead of the current cpu_is_? checks.
> 
> Reviewed-by: Mike Turquette <mturquette@linaro.org>

Thanks, queued for 3.17 with the exception of patch 1 which was previously 
queued.


- Paul
