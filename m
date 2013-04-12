From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 12 Apr 2013 10:55:38 +0800
Subject: [PATCH] video: mxsfb: Adapt to new videomode API
In-Reply-To: <CAOMZO5BrkRx6zYraea1Bnqppf0WAO8rztUyA0ewm9Qw0wFbo_A@mail.gmail.com>
References: <1365516978-29888-1-git-send-email-fabio.estevam@freescale.com>
 <20130412021111.GD16970@S2101-09.ap.freescale.net>
 <CAOMZO5BrkRx6zYraea1Bnqppf0WAO8rztUyA0ewm9Qw0wFbo_A@mail.gmail.com>
Message-ID: <20130412025536.GE16970@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 11:24:19PM -0300, Fabio Estevam wrote:
> On Thu, Apr 11, 2013 at 11:11 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> >> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> >> index d90e3f5..240f863 100644
> >> --- a/drivers/video/Kconfig
> >> +++ b/drivers/video/Kconfig
> >> @@ -2428,6 +2428,7 @@ config FB_MXS
> >>       select FB_CFB_IMAGEBLIT
> >>       select FB_MODE_HELPERS
> >>       select OF_VIDEOMODE
> >
> > OF_VIDEOMODE is dead now, and should be removed.
> 
> Ok, but should I remove this on a separate patch?

I do not think so, as VIDEOMODE_HELPER is introduced to just replace
OF_VIDEOMODE and a couple of other symbols.

Shawn
