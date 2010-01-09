From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 9 Jan 2010 22:03:39 +0100
Subject: [PATCH] S3C: Remove unneeded __init symbols
In-Reply-To: <20100109100430.5258.8254.stgit@localhost>
References: <20100109100430.5258.8254.stgit@localhost>
Message-ID: <20100109210339.GB10587@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nelson,

On Sat, Jan 09, 2010 at 05:04:30AM -0500, Nelson Castillo wrote:
> Two functions defined with __init are also exported.
> Let's remove the __init symbols in order to avoid two warnings.
Can you quote the warnings please?

And I thought you agreed that "unneeded" for __init isn't optimal.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
