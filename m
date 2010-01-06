From: arhuaco@freaks-unidos.net (Nelson Castillo)
Date: Wed, 6 Jan 2010 12:27:29 -0500
Subject: [PATCH 1/2] Remove unneeded __init from s3c24xx_ts_set_platdata
In-Reply-To: <20100106165933.GA26395@pengutronix.de>
References: <20100106094146.17269.6955.stgit@localhost>
	<20100106165933.GA26395@pengutronix.de>
Message-ID: <2accc2ff1001060927i28827aeam1400d32cf2efbe5b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/1/6 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
> On Wed, Jan 06, 2010 at 04:41:47AM -0500, Nelson Castillo wrote:
>> Remove unneeded __init in function definition.
> you should only remove '__init's if they are wrong. ?And if these are
> wrong, you should point out why.

Sure.

It's  because the functions are both marked as __init and they're
exported and we get a warning at build time. I should have written
this in the patch :-/ I'll resend them later if no mpre comments are
received.
