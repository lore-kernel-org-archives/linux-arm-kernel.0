From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 8 Oct 2010 15:57:33 +0200
Subject: [PATCH v2] i.MX35: use the correct IIM register to get CPU
	revision
In-Reply-To: <1286525909-30956-1-git-send-email-eric@eukrea.com>
References: <1286524957-30218-1-git-send-email-eric@eukrea.com>
	<1286525909-30956-1-git-send-email-eric@eukrea.com>
Message-ID: <20101008135733.GK29673@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Oct 08, 2010 at 10:18:29AM +0200, Eric B?nard wrote:
> instead of using ROM_SI_REV use IIM's Silicon Revision register
> as described in :
> - Reference Manual 29.3.3.10
> - RM Errata 29.3.3.9.13
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>
OK, based on this I resend the three patches.  I squashed Eric's
"i.MX35: use the correct IIM register to get CPU revision" and Sascha's
"5f3282f0821ece24f9423d1ac819c398eed5947f" together, fixed up the
conflicts (as Eric seems not to have used my latest patches) and removed
a few things that became superflous then.
(I kept Sascha's short description and as a countermove took Eric as
author.  I hope this is OK for you.)

Patches 1 and 3 are unaffected, but I resend them to have them together.

Sascha: as before: you need to drop
dcdb3b1cf9b327cf91ee6eaff61d809619bd98f4 from your branch before
applying this series.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
