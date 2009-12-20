From: andy@warmcat.com (Andy Green)
Date: Sun, 20 Dec 2009 13:02:16 +0000
Subject: Using SD cards on Samsung S3C2410/S3C2440 based systems
In-Reply-To: <200912201322.23013.jbe@pengutronix.de>
References: <200912151443.59761.jbe@pengutronix.de>	<4B27C808.7080800@warmcat.com>
	<200912201322.23013.jbe@pengutronix.de>
Message-ID: <4B2E2058.5070604@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/09 12:22, Somebody in the thread at some point said:

Hi -

> Yes, all signals except the clock are pulled up to +5V (10K), and a small cap
> to ground (don't know their values yet).

Actually, they shouldn't be pulled up to your SD Card power rail.

If 5V IS your SD Card power rail, I have some bad news for you...

http://www.sdcard.org/developers/tech/

-Andy
