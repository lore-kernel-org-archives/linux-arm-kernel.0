From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 16 Feb 2016 08:33:27 +0100
Subject: [PATCH v3 0/3] Input: rotary_encoder - Fixups for Dmitry's
 rework and support for >2 gpios
In-Reply-To: <1454674101-1194-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1454674101-1194-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20160216073327.GL12289@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Dmitry,

On Fri, Feb 05, 2016 at 01:08:18PM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> This bases on top of
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input rotary-encoder
> 
> (currently at 557a30f2f046).
> 
> Dmitry, I assume you will squash the two fixups accordingly, otherwise
> just tell me, then I create proper patches.
> 
> Also let me note that with threaded irqs I'm able to rotate my device
> quicker than irq handling happens. So a quick counterclockwise rotation
> might be detected as single step clockwise rotation.

gentle ping!

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
