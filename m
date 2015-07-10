From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 10 Jul 2015 16:39:41 +0200
Subject: [PATCH] soc: mediatek: Drop owner assignment from platform_driver
In-Reply-To: <20150710071524.GW18700@pengutronix.de>
References: <1436509789-27361-1-git-send-email-k.kozlowski@samsung.com>
 <20150710071524.GW18700@pengutronix.de>
Message-ID: <2465585.M6dBSSGdRG@ubix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, July 10, 2015 09:15:24 AM Sascha Hauer wrote:
> On Fri, Jul 10, 2015 at 03:29:45PM +0900, Krzysztof Kozlowski wrote:
> > platform_driver does not need to set an owner because
> > platform_driver_register() will set it.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> 

applied, thanks.
