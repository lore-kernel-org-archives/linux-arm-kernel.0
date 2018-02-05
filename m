From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 5 Feb 2018 18:37:20 +0800
Subject: [PATCH v2 BUGFIX] ARM: dts: imx6ull: fix the imx6ull-14x14-evk
 configuration
In-Reply-To: <20180205105543.1711274c@karo-electronics.de>
References: <1516955159-21626-1-git-send-email-LW@KARO-electronics.de>
 <1516956738-24673-1-git-send-email-LW@KARO-electronics.de>
 <20180205075620.GO31354@dragon>
 <20180205105543.1711274c@karo-electronics.de>
Message-ID: <20180205103716.GY31354@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 05, 2018 at 10:55:43AM +0100, Lothar Wa?mann wrote:
> Hi,
> 
> On Mon, 5 Feb 2018 15:56:22 +0800 Shawn Guo wrote:
> > On Fri, Jan 26, 2018 at 09:52:18AM +0100, Lothar Wa?mann wrote:
> > > imx6ull-14x14-evk.dts currently includes the imx6ul.dtsi file for an
> > > i.MX6ULL SoC which is plain wrong.
> > > 
> > > Rename the current imx6ul-14x14-evk.dts to .dtsi and include it from
> > > imx6ul-14x14-evk.dts and imx6ull-14x14-evk.dts, so that both can
> > > include the appropriate SoC specific (imx6ul.dtsi/imx6ull.dtsi) file.
> > > 
> > > Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> > 
> > Which base is the patch generated against?  I cannot apply it to any
> > branch in my tree.
> >
> The patch was generated against next-20180118 but also applies to
> next-20180205.

It looks like you would really want this go into 4.16 as a fix?  In that
case, I will need to wait for v4.16-rc1 to apply it.

Shawn
