From: rmk@arm.linux.org.uk (Russell King)
Date: Tue, 3 Nov 2009 21:01:15 +0000
Subject: [PATCH 1/2] [ARM] i2c/pxa: remove unused macro
In-Reply-To: <1257275000-18866-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1257275000-18866-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20091103210115.GA24955@flint.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2009 at 08:03:19PM +0100, Uwe Kleine-K?nig wrote:
> Commit
> 
> 	beea494 ([ARM] Remove EEPROM slave emulation from i2c-pxa driver.)

Oh great.  Some people may remember the LX code that I submitted to
the mailing list a while back.  Removing the slave emulation buggers
that platform up.  I do intend to submit that once the issue of where
the PCON support should be located is resolved - which is still
pending.

Please revert this change, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
