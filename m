From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 24 Sep 2013 23:11:39 +0200
Subject: Timekeeping on at91rm9200 [Was: [PATCH v2] clockevents: Sanitize
 ticks to nsec conversion]
In-Reply-To: <1380052223-24139-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <alpine.DEB.2.02.1309191629040.4089@ionos.tec.linutronix.de>
 <1380052223-24139-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20130924211139.GE16106@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Nicolas, hello Jean-Christophe,

I expect you should be able to revert 

	b7a8ca5 (ARM: at91: rm9200 fix time support)

which reverted 

	838a2ae (ARM: use clockevents_config_and_register() where possible)

for at91rm9200 on top of the patch this mail is a reply to.

Can you please test that?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
