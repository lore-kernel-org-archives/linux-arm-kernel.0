From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 8 Jul 2013 17:29:17 +0200
Subject: [PATCH] ARM: ARMv7-M: Fix name of NVIC handler function
In-Reply-To: <1372238855-26112-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1372238855-26112-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20130708152917.GE29556@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, Jun 26, 2013 at 11:27:35AM +0200, Uwe Kleine-K?nig wrote:
> The name changed in response to review comments for the nvic irqchip
> driver when the original name was already accepted into Russell King's
> tree.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> this patch was part of the irqchip patch v4, but I split it out for
> being easier to merge in v5. It applies on top of Russell's devel-stable
> branch.
> 
> Russell: I put it on top of my for-next branch (
> 
> 	git://git.pengutronix.de/git/ukl/linux.git for-next
> 
> ) that you merged into your devel-stable some time ago. So assuming
> you're fine with the patch, you can just repull or I can put it into
> your patch tracker if you prefer it. In the latter case please tell me.
The mismatch hit Linus' tree now. How should this patch get to him?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
