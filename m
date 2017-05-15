From: aisheng.dong@nxp.com (A.S. Dong)
Date: Mon, 15 May 2017 12:08:22 +0000
Subject: [PATCH 5/5] pinctrl: imx: fix debug message for
 SHARE_MUX_CONF_REG case
In-Reply-To: <20170515120555.GR8471@dragon>
References: <1494592686-30967-1-git-send-email-aisheng.dong@nxp.com>
 <1494592686-30967-7-git-send-email-aisheng.dong@nxp.com>
 <20170515120555.GR8471@dragon>
Message-ID: <AM3PR04MB306832D30685F0239BA37BC80E10@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Monday, May 15, 2017 8:06 PM
> To: A.S. Dong
> Cc: linux-gpio at vger.kernel.org; Andy Duan; Jacky Bai;
> linus.walleij at linaro.org; stefan at agner.ch; kernel at pengutronix.de; linux-
> arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 5/5] pinctrl: imx: fix debug message for
> SHARE_MUX_CONF_REG case
> 
> On Fri, May 12, 2017 at 08:38:06PM +0800, Dong Aisheng wrote:
> > The original implemented debug message does not work for
> > SHARE_MUX_CONF_REG case. This patch fixes it.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Fixes: bf5a530971af ("pinctrl: imx: add VF610 support to imx pinctrl
> > framework")
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> 
> Fixes should go first in a patch series.
> 

That's true.
Thanks for the suggestion.

Regards
Dong Aisheng

> Shawn
