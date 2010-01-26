From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 26 Jan 2010 12:35:34 +0100
Subject: whoever is using ymiao3@marvell.com please stop it
In-Reply-To: <20100126052317.GY10014@trinity.fluff.org>
References: <20100125014024.GA4609@trinity.fluff.org>
	<f17812d71001251730p4747199bhd4176d5835073b56@mail.gmail.com>
	<20100126052317.GY10014@trinity.fluff.org>
Message-ID: <20100126113534.GF20792@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Jan 26, 2010 at 05:23:18AM +0000, Ben Dooks wrote:
> On Tue, Jan 26, 2010 at 09:30:39AM +0800, Eric Miao wrote:
> > That's mine original email, and is invalid now. Everyone please stop using it.
I already run into that several times as I frequently use
scripts/get_maintainer.pl.  IMHO we need a mechanism to deprecate email
addresses, preferably using .mailmap as data source.  Other addresses
that would need similar handling are (at least):

	12o3l at tiscali.nl -> roel.kluin at gmail.com
	damm at igel.co.jp -> damm at opensource.se
	eric.miao at marvell.com -> eric.y.miao at gmail.com
	jarkko.nikula at nokia.com -> jhnikula at gmail.com
	pavel at suse.cz -> pavel at ucw.cz
	spyro at f2s.com -> ian at mnementh.co.uk
	x0044955 at ti.com -> ??

I'd suggest to check if the address is listed in .mailmap and use the
first entry for that person.  This would need some work to adapt
.mailmap, as .mailmap mainly collects wrong entries.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
