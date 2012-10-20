From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 20 Oct 2012 18:58:10 +0000 (UTC)
Subject: OMAP baseline test results for v3.7-rc1
In-Reply-To: <20121020183724.GA9984@netboy.at.omicron.at>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
 <20121020141136.GA6433@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210201615170.24497@utopia.booyaka.com>
 <20121020180123.GA2630@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210201807170.27264@utopia.booyaka.com>
 <20121020183724.GA9984@netboy.at.omicron.at>
Message-ID: <alpine.DEB.2.00.1210201856020.27264@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 20 Oct 2012, Richard Cochran wrote:

> On Sat, Oct 20, 2012 at 06:12:35PM +0000, Paul Walmsley wrote:
> > Just tried omap2plus_defconfig here and the board didn't boot, confirming 
> > your result.  Will add a section to the testlog README.txt about that.
> > 
> > > > In terms of differences from your setup, looks like we have different 
> > > > X-Loader and u-boot; it wouldn't surprise me if we have different kernel 
> > > > configs too.
> 
> I tried both omap2plus_defconfig and your am33xx_only config, and
> neither one work with my (recent) u-boot version.

Just sent you the MLO and u-boot.img from here via private E-mail.  Those 
were the files that came with the BeagleBone SD card here.

TI also has a u-boot tree for the AM33xx; might be worth trying:

git://arago-project.org/git/projects/u-boot-am33x.git


- Paul
