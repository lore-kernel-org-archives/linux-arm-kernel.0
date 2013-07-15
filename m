From: b32955@freescale.com (Huang Shijie)
Date: Mon, 15 Jul 2013 16:30:27 +0800
Subject: [PATCH 1/3] serial: mxs: remove the unused macro
In-Reply-To: <20130715082044.GL12139@pengutronix.de>
References: <1373857736-30108-1-git-send-email-b32955@freescale.com>
 <20130715082044.GL12139@pengutronix.de>
Message-ID: <51E3B323.1070606@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?07?15? 16:20, Uwe Kleine-K?nig ??:
> You're suggesting that MXS_AUART_DMA_CONFIG was set here unconditionally
> before and so the check in the hunk above is not necessary anymore.
yes, that's what i want to say.
> (<pedantic>So your "not used any more" is technically wrong.</pedantic>)
ok, I will change this comment.

thanks
Huang Shijie
