From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 8 Oct 2012 17:43:25 +0200
Subject: new branch for linux-next [Was: [PATCH v6 0/3] Updated Cortex-M3
 series]
In-Reply-To: <1343988614-5508-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343988614-5508-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20121008154325.GF18531@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Stephen,

I already tried several times to get feedback from Russell King (as you
probably know he's the ARM maintainer and busy most of the time) for my
series to support Cortex-M3 machines. As I think the outcome will
probably (at least) be that it should be included in next for some time
first (as for example Arnd Bergmann already suggested), can you please
add

	git://git.pengutronix.de/git/ukl/linux-2.6.git for-next

to your tree? I'd suggest adding it after arm and arm-soc.
I intend to use this branch later for efm32 support (which depends on
the Cortex-M3 stuff).

Currently the branch is still empty, but I intend to fill it with what I
consider to be applyable after I did some more testing. (Mainly to
assert it still does what it did when I developed it on an older base.)

@Russell: I hope this is OK for you. If not, I'm sure you'll protest.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
