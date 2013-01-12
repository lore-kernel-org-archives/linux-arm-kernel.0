From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 12 Jan 2013 11:58:48 +0000
Subject: [PATCH 3/4] ARM: imx: restore uncompress.h to a common place
In-Reply-To: <20130112110438.GB14865@S2101-09.ap.freescale.net>
References: <1355319945-3199-1-git-send-email-shawn.guo@linaro.org>
 <50F101F4.8080009@gmail.com>
 <20130112110438.GB14865@S2101-09.ap.freescale.net>
Message-ID: <201301121158.49128.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 12 January 2013, Shawn Guo wrote:
> On Sat, Jan 12, 2013 at 07:25:56AM +0100, Dirk Behme wrote:

> > In case you touch these patches again, you might check if the above
> > path and file name in the file header should be adapted to the new
> > file location, too.
> > 
> I would not bother to update that.  To me, it's quite pointless to have
> a full file name there.  If I can choose, I would remove it completely.

I agree, they tend to all get wrong over time. It's not worth
removing those statements all at once, but I also remove them
when moving files and I remember.

	Arnd
