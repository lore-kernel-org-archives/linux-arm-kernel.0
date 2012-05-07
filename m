From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 7 May 2012 21:54:53 +0800
Subject: [GIT PULL] mxs: device tree support for v3.5
In-Reply-To: <CAOesGMjrJe++s-tmgzs2oY1T9GVntngV71-2iqZhfWx2EiZL_g@mail.gmail.com>
References: <20120405013556.GI7264@S2101-09.ap.freescale.net>
 <CAOesGMjrJe++s-tmgzs2oY1T9GVntngV71-2iqZhfWx2EiZL_g@mail.gmail.com>
Message-ID: <20120507135451.GI19389@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 15, 2012 at 11:29:54AM -0700, Olof Johansson wrote:
> On Wed, Apr 4, 2012 at 6:36 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > Hi Arnd, Olof,
> >
> > Please pull the mxs basic device tree support for -next, so that people
> > can start playing and contributing mxs device tree conversion. ?Thanks.
> >
> > Regards,
> > Shawn
> >
> > ---
> > The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:
> >
> > ?Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)
> >
> > are available in the git repository at:
> > ?git://git.linaro.org/people/shawnguo/linux-2.6.git mxs/dt
> 
> Thanks, pulled.
> 
> Sorry for the delay, we've been late at starting up the branches for 3.5.
> 
Hi Arnd, Olof,

Please abandon this branch.  It will be broken due to the mxs common
clk and pinctrl series.  I'm going to send an updated mxs device tree
branch based on common-clk and pinctrl support after I send those two
prerequisites to you.

-- 
Regards,
Shawn
