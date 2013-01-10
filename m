From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 Jan 2013 10:09:04 +0800
Subject: [PATCH 3/4] ARM i.MX53: add dts for the TQ tqma53 module
In-Reply-To: <CAOMZO5BXKbjh1J+ms2b4taGaT34xAUM+L3E4FouyZ6tOnQTofg@mail.gmail.com>
References: <1357739065-9153-1-git-send-email-s.trumtrar@pengutronix.de>
 <1357739065-9153-4-git-send-email-s.trumtrar@pengutronix.de>
 <CAOMZO5BXKbjh1J+ms2b4taGaT34xAUM+L3E4FouyZ6tOnQTofg@mail.gmail.com>
Message-ID: <20130110020903.GD2265@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 09, 2013 at 02:30:34PM -0200, Fabio Estevam wrote:
> On Wed, Jan 9, 2013 at 11:44 AM, Steffen Trumtrar
> <s.trumtrar@pengutronix.de> wrote:
> 
> > +
> > +&wdog1 {
> > +       status = "okay";
> > +};
> 
> This can be removed, since imx53.dtsi already enables the watchdog.

I fixed it up and applied the patch.

Shawn
