From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 26 Oct 2010 16:16:57 +0200
Subject: [PATCH RFC] MXC IOMUX-V3 replace struct pad_desc with
	bitmapped cookie
In-Reply-To: <1288084042-21722-1-git-send-email-LW@KARO-electronics.de>
References: <20101025072126.GG8554@pengutronix.de>
	<1288084042-21722-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20101026141657.GA5445@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

On Tue, Oct 26, 2010 at 11:07:21AM +0200, Lothar Wa?mann wrote:
> The following patch is a first step to convert the 'struct pad_desc'
> to a bitmapped cookie to facilitate adding platform specific pullup or
> drive strength definitions to existing pad definitions without need to
> rewrite the complete pad def.

I'm all in favour for this patch. I regret that I haven't implemented it
this way in the first time.
I think we should delay this to the next merge window though because
it introduces a change for many i.MX boards. Some more testing for this
patch is a good thing.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
