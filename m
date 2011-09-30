From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 30 Sep 2011 22:14:42 +0800
Subject: [PATCH 1/2] arm/mx5: add device tree support for imx53 boards
In-Reply-To: <CAOMZO5Cn3MvvoejPDyfz4gQZipNKASZoscsZn5ahzrV240HB_A@mail.gmail.com>
References: <1317389747-24589-1-git-send-email-shawn.guo@linaro.org>
	<1317389747-24589-2-git-send-email-shawn.guo@linaro.org>
	<CAOMZO5Cn3MvvoejPDyfz4gQZipNKASZoscsZn5ahzrV240HB_A@mail.gmail.com>
Message-ID: <20110930141441.GE19807@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2011 at 10:56:48AM -0300, Fabio Estevam wrote:
> On Fri, Sep 30, 2011 at 10:35 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > From: Shawn Guo <shawn.guo@freescale.com>
> >
> > It adds device tree support for imx53 boards.
> >
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Acked-by: Grant Likely <grant.likely@secretlab.ca>
> > ---
> > ?Documentation/devicetree/bindings/arm/fsl.txt | ? 15 ++
> > ?arch/arm/boot/dts/imx53-ard.dts ? ? ? ? ? ? ? | ?113 ++++++++++
> > ?arch/arm/boot/dts/imx53-evk.dts ? ? ? ? ? ? ? | ?120 +++++++++++
> > ?arch/arm/boot/dts/imx53-qsb.dts ? ? ? ? ? ? ? | ?125 +++++++++++
> 
> Can't you call it imx53-loco.dts instead so that it is consistent with
> mach-mx53_loco.c ?
> 
No.  I was taking this opportunity to fix the naming.  "loco" is a bad
name and is not recommended any more.  Eventually, board-mx53_loco.c
will be killed by imx53-dt.c, which means "loco" will be killed
eventually.

-- 
Regards,
Shawn
