From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 22 Feb 2016 11:27:56 +0100
Subject: [PATCH] reset: lpc18xx: get rid of global variables for restart
 notifier
In-Reply-To: <1455995209-5213-1-git-send-email-manabian@gmail.com>
References: <1455995209-5213-1-git-send-email-manabian@gmail.com>
Message-ID: <1456136876.5148.25.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joachim,

Am Samstag, den 20.02.2016, 20:06 +0100 schrieb Joachim Eastwood:
> Moving the notifier_block into the drivers priv struct allows us
> to retrive the priv struct with container_of and remove the
> global variables.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
> Hi Philipp,
> 
> Just a simple clean up patch for lpc18xx reset controller.

Thanks, applied to reset/next.

regards
Philipp
