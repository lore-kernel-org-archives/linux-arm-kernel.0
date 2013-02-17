From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 17 Feb 2013 20:04:44 +0800
Subject: [PATCH 1/3] ARM: dts: imx28-evk: Enable touchscreen support
In-Reply-To: <201302171131.24908.marex@denx.de>
References: <1360337803-19858-1-git-send-email-festevam@gmail.com>
 <20130217075406.GD15048@S2101-09.ap.freescale.net>
 <201302171131.24908.marex@denx.de>
Message-ID: <20130217120442.GB6782@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 17, 2013 at 11:31:24AM +0100, Marek Vasut wrote:
> Dear Shawn Guo,
> 
> > On Fri, Feb 08, 2013 at 01:36:41PM -0200, Fabio Estevam wrote:
> > > From: Fabio Estevam <fabio.estevam@freescale.com>
> > > 
> > > Provide 'lradc-touchscreen-wires' property to the LRADC driver, so that
> > > touchscreen can be functional.
> > > 
> > > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > 
> > Queued all 3 for 3.10.
> 
> I dont intend to ramble or annoy you (I already did that plenty ;-) ), but can 
> we not speed this up and push these simple stuffs for 3.9?

No. arm-soc folks require that material for each merge window should be
reaching them around -rc6 time (2 weeks to opening of the merge window).
So it's simply late for 3.9.

Shawn
