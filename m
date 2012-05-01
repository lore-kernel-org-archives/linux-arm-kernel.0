From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 2 May 2012 07:39:41 +0800
Subject: [PATCH 10/11] ARM: imx6q_sabrelite: clkdev_add cko1 for sgtl5000
In-Reply-To: <20120501124706.GF2194@S2101-09.ap.freescale.net>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
 <1335510185-7906-11-git-send-email-richard.zhao@freescale.com>
 <20120501124706.GF2194@S2101-09.ap.freescale.net>
Message-ID: <20120501233939.GO2194@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 01, 2012 at 08:47:10PM +0800, Shawn Guo wrote:
> > +	clk_register_clkdev(cko1, NULL, "0-000a");
> 
> This dev_id looks a little strange to me.  I understand that's the
> consequence of having sgtl5000 clock managed in ASoC machine driver
> imx-sgtl5000.
> 
Just realised it's not the case.  But shouldn't the name look like
"sgtl5000.0-000a"?

-- 
Regards,
Shawn
