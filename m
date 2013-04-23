From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 23 Apr 2013 19:47:42 +0800
Subject: [PATCH 3/3] pinctrl: add MVF pinctrl driver
In-Reply-To: <B56CDBE15CE27145A4B77D2D24263E851B17D9@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1365753432-14247-1-git-send-email-b35083@freescale.com>
 <20130422145727.GA27475@S2101-09.ap.freescale.net>
 <B56CDBE15CE27145A4B77D2D24263E851B17D9@039-SN1MPN1-003.039d.mgd.msft.net>
Message-ID: <20130423114740.GC27475@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 10:09:46AM +0000, Lu Jingchang-B35083 wrote:
> >> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> >> ---
> >>  .../bindings/pinctrl/fsl,mvf-pinctrl.txt           |  825 ++++++++
> >>  drivers/pinctrl/Kconfig                            |    8 +
> >>  drivers/pinctrl/Makefile                           |    1 +
> >>  drivers/pinctrl/pinctrl-mvf.c                      | 2042
> >++++++++++++++++++++
> >
> >We just removed those big arrays of imx_pin_reg from imx pinctrl soc
> >drivers.  Please do not bring it back for MVF.
> >
> [Lu Jingchang-B35083] 
> What's the status of your new i.mx pinctrl framework? I found that there are some discussion for that, Are they accepted? Where can I find the latest code so I can use it as the base for MVF platform? Thanks.
> 
It's on linux-next right now, and should be merged in the coming 3.10
window.

Shawn
