From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 30 Jun 2012 18:52:26 +0100
Subject: [PATCH 3/3] mtd: gpmi: change the code for clocks
In-Reply-To: <20461.30070.771087.830745@ipc1.ka-ro>
References: <1340941925-14591-1-git-send-email-shijie8@gmail.com>
 <1340941925-14591-3-git-send-email-shijie8@gmail.com>
 <20120629020650.GB28932@S2101-09.ap.freescale.net>
 <20120629063329.GE5844@shlinux2.ap.freescale.net>
 <20461.30070.771087.830745@ipc1.ka-ro>
Message-ID: <20120630175225.GC21029@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2012 at 11:29:26AM +0200, Lothar Wa??mann wrote:

> Instead the driver should request the maximum number of clocks that
> the existing set of platforms provide and all platforms with fewer
> clocks should provide an appropriate number of dummy clocks.

Or the driver could handle missing clocks, that can make more sense in
some cases.
