From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 10 Oct 2011 08:36:38 +0200
Subject: [PULL] i.MX
In-Reply-To: <20111004092015.GM31404@pengutronix.de>
References: <20111004092015.GM31404@pengutronix.de>
Message-ID: <20111010063638.GA22100@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Sascha,

On Tue, Oct 04, 2011 at 11:20:15AM +0200, Sascha Hauer wrote:
> Arnaud Patard (2):
>       Fix pata imx resource

when Sascha was on vacation I already let Arnd pull that commit squashed
into the originating commit (Message-ID:
<20110906192229.GK28816@pengutronix.de>). Now he got it back eventually breaking
bisection :-(

>       efika: Configure esdhc cd/wp on efika mx/sb
> 
> Fabio Estevam (3):
>       ARM: mach-qong: Add watchdog support
>       ARM: mach-mxs/mx28evk: Only register devices if their GPIO requests succeeded
>       ARM: mxs: Consolidate mm-mx23.c and mm-mx28.c into a single file
> 
> Hui Wang (1):
>       ARM i.MX avic: convert to use generic irq chip
> 
> Jason Liu (4):
>       ARM: mx5/mm: move i.MX50 mm stuff into mm.c
>       ARM: mx5/mm: Remove MX51_DEBUG related mapping
>       ARM: mx5/mm: consolidate TZIC map code
>       ARM: mx25: Add the missing IIM base definition
Same here, I squashed that commit into

	d27536c (ARM: mx25: Print silicon revision on boot)

If you care I can help you to resolve these issues via irc.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
