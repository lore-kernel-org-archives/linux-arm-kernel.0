From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 20 Sep 2012 22:53:44 +0800
Subject: [PATCH v2 00/34] i.MX multi-platform support
In-Reply-To: <201209200739.34899.arnd@arndb.de>
References: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
 <201209200739.34899.arnd@arndb.de>
Message-ID: <20120920145342.GI2450@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 07:39:34AM +0000, Arnd Bergmann wrote:
> The first five branches are scheduled to go through the arm-soc tree, so
> I'm fine with that. For the sound/for-3.7 branch, I'd like to know when
> to expect that hitting mainline. If it always gets in very early during the
> merge window, it's probably ok to put the imx/multi-platform patches into
> the same branch as the other ones in arm-soc and wait for the sound stuff
> to hit mainline first, otherwise I'd suggest we start a second
> next/multiplatform-2 branch for imx and send the first part early on
> but then wait with the second batch before sound gets in.
> 
It seems that we will have to go with next/multiplatform-2.  I just
tried to merge the series with linux-next together, and got some
non-trivial conflicts with media and mtd tree.  I might have to rebase
my series on top of these trees to sort out those conflicts.  That said,
I will have several dependencies outside arm-soc tree, and have to pend
my series until all those trees get merged into mainline.

Shawn
