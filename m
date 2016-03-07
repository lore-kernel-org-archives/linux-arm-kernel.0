From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 7 Mar 2016 10:32:15 +0700
Subject: [GIT PULL 2/4] ARM: imx: device tree changes for 4.6
In-Reply-To: <1580747.WVsjDBS4QB@wuerfel>
References: <1456844403-26176-1-git-send-email-shawnguo@kernel.org>
 <1456844403-26176-2-git-send-email-shawnguo@kernel.org>
 <1580747.WVsjDBS4QB@wuerfel>
Message-ID: <20160307033214.GB5051@x250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2016 at 09:26:29PM +0100, Arnd Bergmann wrote:
> On Tuesday 01 March 2016 23:00:01 Shawn Guo wrote:
> > Hi arm-soc maintainers,
> > 
> > This is the i.MX device tree updates for 4.6.  To resolve the dependency
> > between clock drivers and DTS files on some new clock ID additions, the
> > branch imx/clk are pulled into the branch.  The imx/clk changes have
> > been sent to clk folks as a stable branch.
> 
> I'm not overly happy with this: you are pulling in a rather big
> change to the clk driver in the middle of a huge pull request,
> and this is the first pull request for the 4.6 cycle.
> 
> The changes otherwise all look reasonable, so I've put it all into
> a next/dt2 branch. Please try to stage things out a little more
> again next time: send the bulk of the changes a little earlier
> if you can, and put changes that require other dependencies into
> separate branches.

Okay.  I will try to follow the suggestions in the future to make your
job bit easier.

Shawn
