From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 22 Dec 2011 19:43:20 +0800
Subject: [PATCH 2/4] regulator: mc13892: remove the unnecessary prefix
 from regulator name
In-Reply-To: <20111222110830.GI4546@opensource.wolfsonmicro.com>
References: <1324479647-4580-1-git-send-email-shawn.guo@linaro.org>
 <1324479647-4580-3-git-send-email-shawn.guo@linaro.org>
 <20111222110830.GI4546@opensource.wolfsonmicro.com>
Message-ID: <20111222114319.GA6806@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2011 at 11:08:30AM +0000, Mark Brown wrote:
> On Wed, Dec 21, 2011 at 11:00:45PM +0800, Shawn Guo wrote:
> > It's not really necessary to add a prefix 'MC13892__' for each mc13892
> > regulator name, since the chip must have been identified as mc13892
> > when we look at the regulator name.
> 
> Applied, thanks.
> 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > Cc: Liam Girdwood <lrg@ti.com>
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Think something went wrong with your scripts here...  might be worth
> checking.

Yes, something did go wrong there.  Thanks for noticing.

-- 
Regards,
Shawn
