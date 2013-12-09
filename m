From: dinguyen@altera.com (Dinh Nguyen)
Date: Mon, 9 Dec 2013 13:41:23 -0600
Subject: [PATCHv5 2/4] clk: socfpga: Add a hook for SD/MMC driver to
 control CIU clock settings
In-Reply-To: <201312091728.07940.arnd@arndb.de>
References: <1386597462-29471-1-git-send-email-dinguyen@altera.com>
 <1386597462-29471-3-git-send-email-dinguyen@altera.com>
 <201312091728.07940.arnd@arndb.de>
Message-ID: <1386618083.29889.17.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-12-09 at 17:28 +0100, Arnd Bergmann wrote:
> On Monday 09 December 2013, dinguyen at altera.com wrote:
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Populate the .prepare function in the clk-ops for the "sdmmc_clk" that represents
> > the "ciu" clock for the SD/MMC driver. The prepare function will handle setting
> > the correct clock-phase for the CIU clock of the SD/MMC IP.
> > 
> > Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> 
> Please see my comments for this patch for v4, it still looks wrong to me.
> The other three patches are good though.

I apologize for missing your V4 comments. It somehow never ended in my
Altera mbox but is there at gmail. I will address them.

Dinh
> 
> 	Arnd
> 
