From: richardcochran@gmail.com (Richard Cochran)
Date: Sat, 20 Oct 2012 20:37:24 +0200
Subject: OMAP baseline test results for v3.7-rc1
In-Reply-To: <alpine.DEB.2.00.1210201807170.27264@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
 <20121020141136.GA6433@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210201615170.24497@utopia.booyaka.com>
 <20121020180123.GA2630@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210201807170.27264@utopia.booyaka.com>
Message-ID: <20121020183724.GA9984@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 20, 2012 at 06:12:35PM +0000, Paul Walmsley wrote:
> Just tried omap2plus_defconfig here and the board didn't boot, confirming 
> your result.  Will add a section to the testlog README.txt about that.
> 
> > > In terms of differences from your setup, looks like we have different 
> > > X-Loader and u-boot; it wouldn't surprise me if we have different kernel 
> > > configs too.

I tried both omap2plus_defconfig and your am33xx_only config, and
neither one work with my (recent) u-boot version.

Thanks,
Richard
