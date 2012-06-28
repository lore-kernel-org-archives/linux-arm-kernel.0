From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Jun 2012 20:40:10 +0800
Subject: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
In-Reply-To: <20460.20182.552394.407578@ipc1.ka-ro>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org>
 <1340853701-4488-3-git-send-email-shawn.guo@linaro.org>
 <20120628113327.GJ6406@shlinux2.ap.freescale.net>
 <20120628114559.GE22990@S2101-09.ap.freescale.net>
 <4FEC487A.2050901@pengutronix.de>
 <20120628121817.GA5755@shlinux2.ap.freescale.net>
 <20460.20182.552394.407578@ipc1.ka-ro>
Message-ID: <20120628124008.GB23422@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2012 at 02:32:22PM +0200, Lothar Wa?mann wrote:
> I have created a 'gpio-switch' driver in my private tree that can be
> used for exactly this purpose. It takes care of the pin polarity and
> initial state of the pins and can handle shared pins like in this
> case. The client driver does not even need to care whether an actual
> GPIO exists for the current platform.
> 
> I could prepare a patch and post it here.
> 
That would be great.

-- 
Regards,
Shawn
