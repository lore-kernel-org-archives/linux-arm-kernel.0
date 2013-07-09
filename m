From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 9 Jul 2013 11:28:13 +0800
Subject: [RFC] ARM: dts: imx27: Add core voltages
In-Reply-To: <1373258044.869611579@f137.mail.ru>
References: <1373208662-7350-1-git-send-email-shc_work@mail.ru>
 <20130708015348.GB21594@S2101-09.ap.freescale.net>
 <1373258044.869611579@f137.mail.ru>
Message-ID: <20130709032811.GB16656@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 08, 2013 at 08:34:04AM +0400, Alexander Shiyan wrote:
> > On Sun, Jul 07, 2013 at 06:51:02PM +0400, Alexander Shiyan wrote:
> > > This patch adds core voltages for i.MX27 CPUs. Only 266 and 400 MHz modes
> > > is documented in the datasheet, we add a 266 MHz frequency for conform this.
> > > For 133 MHz CPU frequency minimal voltage is used (1.2V).
> > > 
> > Ok, just checked i.MX27 data sheet, it seems that only 266 and 400 MHz
> > set points are officially supported.  So there is no documented voltage
> > for 133 MHz.  I'm wondering if we should have 133 MHz set point at all
> > if it's not officially supported.
> 
> Then how about removing the frequency of 133MHz, and increase tolerance
> of up to 5% in order to be able to play voltages for devices demanding low
> power consumption?

Sounds good to me.

Shawn
