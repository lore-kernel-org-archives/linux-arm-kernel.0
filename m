From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 11 Jul 2016 07:56:15 -0300
Subject: [PATCH 3/6] ARM: dts: imx25: substitute NO_PAD_CTL by the
 respective reset value
In-Reply-To: <20160711073721.GM16643@pengutronix.de>
References: <1468145266-7567-1-git-send-email-uwe@kleine-koenig.org>
 <1468145266-7567-4-git-send-email-uwe@kleine-koenig.org>
 <CAOMZO5A=6HLPacwp0seBn_s+AVF7zaUjUO8wOb1WoyvU1JrH7A@mail.gmail.com>
 <20160711073721.GM16643@pengutronix.de>
Message-ID: <CAOMZO5ASsA88TQLAPdyit0xr3Lqh8e+8C_ZgoUa7w2rZxTb-ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Mon, Jul 11, 2016 at 4:37 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

>> Then we could later change each 0x80000000 occurrance by replacing it
>> with the actual PAD register value instead of the power on defaults.
>
> Why later?

I was not sure if you had access to all these mx25 boards to verify
the real values used on the pin configurations. I don't have access to
mx25pdk today, but I can access it later this week.

Thanks
