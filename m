From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 3 Nov 2009 22:13:37 +0000
Subject: [PATCH 1/2] [ARM] i2c/pxa: remove unused macro
In-Reply-To: <1257275000-18866-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1257275000-18866-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20091103221337.GJ13398@fluff.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2009 at 08:03:19PM +0100, Uwe Kleine-K??nig wrote:
> Commit
> 
> 	beea494 ([ARM] Remove EEPROM slave emulation from i2c-pxa driver.)
> 
> removed all uses of eedbg, so the definition can go, too.

I belive Russell is trying to sort out the code that was using this
so I would like to put this on hold until we sort out what is going
on.

-- 
Ben (ben at fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
