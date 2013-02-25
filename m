From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 25 Feb 2013 21:33:02 +0800
Subject: [PATCH v2 0/3] Get rid of big array from imx pinctrl driver
In-Reply-To: <20130225081701.GO1906@pengutronix.de>
References: <1361533888-18073-1-git-send-email-shawn.guo@linaro.org>
 <20130225081701.GO1906@pengutronix.de>
Message-ID: <20130225133300.GB2687@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 25, 2013 at 09:17:01AM +0100, Sascha Hauer wrote:
> On Fri, Feb 22, 2013 at 07:51:25PM +0800, Shawn Guo wrote:
> > Changes since v1:
> >  * Remove the absolute path of imxXX-pinfunc.h in binding doc
> >  * Remove the pin id from PIN_FUNC_ID/macro
> > 
> > Shawn Guo (3):
> >   ARM: dts: imx: use pre-processor for device trees
> >   ARM: dts: imx: replace magic number with pin function name
> >   pinctrl: imx: move hard-coding data into device tree
> 
> Looks good to me. The patches are really *huge*. Does it make sense to
> make 2/3 and 3/3 a single patch to make the churn smaller?
> 
Yeah, no problem, as we need to have them go through the same tree
anyway.  I just squashed the two patches into one.

Linus,

May I have your ACK on the pinctrl driver changes?  I would like to
have the series go via IMX tree for 3.10.

Shawn
