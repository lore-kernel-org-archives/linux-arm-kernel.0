From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 10 Mar 2011 18:28:36 +0530
Subject: [PATCH] OMAP4: clockdomain: Follow recommended enable sequence
In-Reply-To: <alpine.DEB.2.00.1103100514210.15132@utopia.booyaka.com>
References: <1299245123-23444-1-git-send-email-rnayak@ti.com>
	<alpine.DEB.2.00.1103081937100.15132@utopia.booyaka.com>
	<4D775418.6050105@ti.com>
	<alpine.DEB.2.00.1103100514210.15132@utopia.booyaka.com>
Message-ID: <4D78CAFC.4080502@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Thursday 10 March 2011 05:48 PM, Paul Walmsley wrote:
> This patch is currently breaking boot on OMAP4430 ES2.0 Pandaboard,
> so I've dropped it from the integration branch until it can be
> debugged.  Could you check it, please?
>
> The tag "integration-2.6.39-20110310-008" of
> git://git.pwsan.com/linux-integration boots fine; it's got everything
> but this patch.  Then when this patch is applied, I2C problems show
> up, and root (on MMC) doesn't mount.

Looks like you are missing this patch which should fix the i2c
timeouts..
http://marc.info/?l=linux-omap&m=129924561819873&w=2

regards,
Rajendra
