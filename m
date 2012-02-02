From: stigge@antcom.de (Roland Stigge)
Date: Thu, 02 Feb 2012 20:20:16 +0100
Subject: [PATCH v2 6/7] LPC32xx: clock.c: USB PLL fix
In-Reply-To: <20120202164920.GC3219@pengutronix.de>
References: <1327939327-7799-1-git-send-email-stigge@antcom.de>
 <1327939327-7799-6-git-send-email-stigge@antcom.de>
 <20120131103401.GJ2471@pengutronix.de> <4F293DAF.4050402@antcom.de>
 <20120202164920.GC3219@pengutronix.de>
Message-ID: <4F2AE1F0.2070200@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On 02/02/2012 05:49 PM, Wolfram Sang wrote:
> Yes, please repost this series with the updates. And without USB &
> MMC updates. Those updates should be in later series, when we
> actually add support for these devices.

OK, reposting.

> First step, I'd suggest: After you repost this series, I'll create
> a branch with the relevant patches (defconfig, buildfixes, clock
> fixes) and send a pull-request to Arnd/Olof. You can decide which
> issue you want to tackle next. I'd think MMC or USB are more of the
> lower hanging fruits, but I leave that to you.

I'd then first repost the GPIO fixes I posted previously and then look
after USB if that's fine for you. :-)

Thanks,

Roland
