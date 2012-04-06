From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 6 Apr 2012 22:21:53 +0800
Subject: Using GPMI-NAND driver on iMX28 using 3.4-rc1?
In-Reply-To: <CAOdLEaontAAN71LkHET7thE5a30wa0EiXPg9b84EOW_GgGoQJg@mail.gmail.com>
References: <CAOdLEaoEDr7fnswwV-Gs8tZF9Zj-RFnRa9Z=eqRFd0==OgV10Q@mail.gmail.com>
 <CAOMZO5AoFnM=cCR-kS4A1k2xY_bRd9+gN1p9bFxdyPS2-UdbkQ@mail.gmail.com>
 <4F7D3DB8.6080009@freescale.com>
 <CAOdLEaoy8ARS=awimR6fN8EcX+FrqxaSr3VUG3rP3zrNLOf+Gw@mail.gmail.com>
 <1333628861.31825.22.camel@vkoul-udesk3>
 <20120406022305.GJ7264@S2101-09.ap.freescale.net>
 <4F7EC6AF.6000603@freescale.com>
 <CAOdLEaoD2sezmXbOoBdZ4h4E+A2rqf-2K9P-Y6aUt+zeASZQrw@mail.gmail.com>
 <20120406135929.GR7264@S2101-09.ap.freescale.net>
 <CAOdLEaontAAN71LkHET7thE5a30wa0EiXPg9b84EOW_GgGoQJg@mail.gmail.com>
Message-ID: <20120406142151.GS7264@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 06, 2012 at 07:06:41AM -0700, Sam Gandhi wrote:
...
> Well then change the name of the function
> mxs_assign_cookie_enable_chan(), my point still stands.
> 
I just do not see the need of such churn.

> As the case illustrates  cookie needs to assigned before enabling the
> channel then why not do it in that function itself.

It's simply because cookie is cookie and channel is channel.

> At worst please
> put a comment in mxs_assign_cookie_enable() that says cookie must be
> assigned prior to calling enable channel.
> 
It's the best rather than worst to me. 

-- 
Regards,
Shawn
