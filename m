From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 7 Apr 2014 21:40:13 +0800
Subject: [PATCH v5 00/11] imx-drm dt bindings
In-Reply-To: <20140407090927.GW7528@n2100.arm.linux.org.uk>
References: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
 <20140311034607.GA26502@S2101-09.ap.freescale.net>
 <20140407042334.GA28025@dragon>
 <20140407090927.GW7528@n2100.arm.linux.org.uk>
Message-ID: <20140407134010.GA2438@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 07, 2014 at 10:09:27AM +0100, Russell King - ARM Linux wrote:
> So no EDID.  Did you update the "ddc" property to "ddc-i2c-bus" ?

Ah, right.  This is exactly the cause.  Thanks, Russell.

Shawn
