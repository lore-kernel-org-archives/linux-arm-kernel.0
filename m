From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 4 Mar 2013 14:36:24 +0800
Subject: [PATCH v2 0/3] Get rid of big array from imx pinctrl driver
In-Reply-To: <CAOesGMjAzSt948+sKRNRzQ3T3F4fbvzBcXYXKmkwW_AAdmiMng@mail.gmail.com>
References: <1361533888-18073-1-git-send-email-shawn.guo@linaro.org>
 <CAOesGMjAzSt948+sKRNRzQ3T3F4fbvzBcXYXKmkwW_AAdmiMng@mail.gmail.com>
Message-ID: <20130304063622.GF30431@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 28, 2013 at 05:24:21PM -0800, Olof Johansson wrote:
> On Fri, Feb 22, 2013 at 3:51 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > Changes since v1:
> >  * Remove the absolute path of imxXX-pinfunc.h in binding doc
> >  * Remove the pin id from PIN_FUNC_ID/macro
> >
> > Shawn Guo (3):
> >   ARM: dts: imx: use pre-processor for device trees
> >   ARM: dts: imx: replace magic number with pin function name
> >   pinctrl: imx: move hard-coding data into device tree
> 
> These patches were too large to make it out on any mailing list. I'm
> guessing only the people who were recipients of them saw them.
> 
> Please figure out a way to post your work in a way that it can be reviewed.

I just merged patches #2 and #3 into one to make the diff stat a little
smaller, as per Sascha's suggestion, and push out the patches to branch
blow.

 git://git.linaro.org/people/shawnguo/linux-2.6.git imx/dt

Shawn
