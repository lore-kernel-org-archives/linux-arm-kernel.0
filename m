From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Thu, 20 Jul 2017 14:39:33 +0200
Subject: IMX53 on recent 4.4.x kernels
In-Reply-To: <D24E577EA1E37B4788A3BFBC418F14A707591D67@wetsrvex01.loepfe.com>
References: <D24E577EA1E37B4788A3BFBC418F14A707591D67@wetsrvex01.loepfe.com>
Message-ID: <20170720123933.rioxhsthaaby4cnl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 20, 2017 at 06:57:37AM +0000, Vellemans, Noel wrote:
> I'm facing a PERFORMANCE problem on recent ARM/IMX  kernels !  ? I
> have ported a recent kernel (4.4.x branch) to one of our custom ARM (
> imx53-based ) boards. This board has been running kernel 2.6.35.x for
> some years, and at this time we decided we needed newer kernel ( for
> wifi operation), so far so good.

Please try a more recent kernel first. 4.4 is quite ancient, and MX53 is
well supported on 4.12 or 4.13+.

Regards,
Robert
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
