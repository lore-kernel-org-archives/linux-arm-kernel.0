From: tony@atomide.com (Tony Lindgren)
Date: Mon, 11 Apr 2016 13:06:26 -0700
Subject: [PATCH v2 00/10] ARM: DTS/clk: DRA7 family: enable eDMA and
 audio updates
In-Reply-To: <570BA7A2.3080507@ti.com>
References: <1457363857-20797-1-git-send-email-peter.ujfalusi@ti.com>
 <570BA7A2.3080507@ti.com>
Message-ID: <20160411200625.GD5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160411 06:34]:
> Tony,
> 
> according to Nishanth, linux-next is broken for dra7 family:
> http://pastebin.ubuntu.com/15758542/ on x15 next-20160411
> because of the missing DT patches.

OK yeah thanks for letting me know.

> Do you want me to resend this series w/o the hwmod patch?

No need to, applying your dts patches into omap-for-v4.7/dt
thanks.

The epwmss entries still produce warnings, looks like there's
discussion still going on with those.

Tony
