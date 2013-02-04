From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 4 Feb 2013 21:12:17 +0800
Subject: [PATCH v6] cpufreq: add imx6q-cpufreq driver
In-Reply-To: <8795375.qIWYRXDKue@vostro.rjw.lan>
References: <1359956789-17918-1-git-send-email-shawn.guo@linaro.org>
 <8795375.qIWYRXDKue@vostro.rjw.lan>
Message-ID: <20130204131213.GA19301@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 01:19:25PM +0100, Rafael J. Wysocki wrote:
> On Monday, February 04, 2013 01:46:29 PM Shawn Guo wrote:
> > Add an imx6q-cpufreq driver for Freescale i.MX6Q SoC to handle the
> > hardware specific frequency and voltage scaling requirements.
> > 
> > The driver supports module build and is instantiated by the platform
> > device/driver mechanism, so that it will not be instantiated on other
> > platforms, as IMX is built with multiplatform support.
> 
> Am I supposed to take it this time? :-)

Yes, finally :)

Shawn
