From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 27 Apr 2012 15:35:48 +0800
Subject: [PATCH 1/2] ARM: imx6q-sabrelite.dts: Add SPI NOR support
In-Reply-To: <20120427062732.GM20039@pengutronix.de>
References: <1335310537-11219-1-git-send-email-festevam@gmail.com>
 <20120427034401.GE2234@S2101-09.ap.freescale.net>
 <CAOMZO5DLwrKJQjZD3RWptd4TjUHq=4HLopnzZbFRFvB60pm8XA@mail.gmail.com>
 <20120427050549.GG2234@S2101-09.ap.freescale.net>
 <20120427062732.GM20039@pengutronix.de>
Message-ID: <20120427073546.GR2234@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 08:27:32AM +0200, Uwe Kleine-K?nig wrote:
> This seems to me to be a userspace problem? My guess is applying the
> patch changed the kernel version (appends '+') and you didn't run make
> modules_install and/or depmod?!
> 
Hmm, what the modules are we missing here?  That's actually my question.
Fabio, Uwe, Sascha, you do not see this error message with your testing?

-- 
Regards,
Shawn
