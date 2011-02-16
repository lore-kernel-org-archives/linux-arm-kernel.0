From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 16 Feb 2011 20:33:17 +0100
Subject: [PATCH] ARM: reenable DEBUG_SECTION_MISMATCH
In-Reply-To: <1297876993-4146-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1297876993-4146-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110216193317.GF22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 16, 2011 at 06:23:13PM +0100, Uwe Kleine-K?nig wrote:
> For 2.6.38-rc4-git9 only 29 out of 133 defconfigs still produce section
> mismatches.  These defconfigs produce 55 mismatches (weighted sum, so
> maybe less uniq mismatches).
> 
> This is in my opinion enough to start scaring people about the remaining
> problems.
@Vincent: Additionally it would be great if kautobuild would recognise
these as warnings.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
