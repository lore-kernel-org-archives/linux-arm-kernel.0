From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Wed, 25 Nov 2009 09:02:20 +0100
Subject: [PATCH 16/38] move s3c_pwm_remove to .devexit.text
In-Reply-To: <1259096853-18909-16-git-send-email-u.kleine-koenig@pengutronix.de>
	("Uwe =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Tue\,
	24 Nov 2009 22\:07\:11 +0100")
References: <1259096853-18909-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-7-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-9-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-10-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-11-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-12-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-13-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-14-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-15-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259096853-18909-16-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <87tywjav77.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Uwe" == Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> writes:

 Uwe> The function s3c_pwm_remove is used only wrapped by __devexit_p so define
 Uwe> it using __devexit.

 Uwe> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
 Uwe> Acked-by: Sam Ravnborg <sam@ravnborg.org>

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
