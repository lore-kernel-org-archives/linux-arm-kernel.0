From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 9 Nov 2009 16:58:03 +0800
Subject: [PATCH 2/2 RESENT] [ARM] i2c/pxa: only define
	'blue_murder'-function if DEBUG is #defined
In-Reply-To: <1257754721-17325-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1257275000-18866-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1257754721-17325-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1257754721-17325-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <f17812d70911090058n4018619p617defe79f43b9d8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/11/9 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> From: Wolfram Sang <w.sang@pengutronix.de>
>
> This talkative function is also called on timeouts. As timeouts can
> happen on regular writes to EEPROMs (no error case), this creates false
> positives. ?Giving lots of details is interesting only for developers
> anyhow, so just use the function if DEBUG is #defined.
>

Well, this does look cleaner. Feel free to take my Ack.
