From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 16 Oct 2009 10:17:22 +0200
Subject: [RFC] mx31moboard: patches for next merge window
In-Reply-To: <1255599780-12948-1-git-send-email-valentin.longchamp@epfl.ch>
References: <1255599780-12948-1-git-send-email-valentin.longchamp@epfl.ch>
Message-ID: <20091016081722.GB7208@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2009 at 11:42:54AM +0200, Valentin Longchamp wrote:
> Here are the patches I would like to push during the next merge window for
> the mx31moboard platform.
> 
> It consists of a fix for a small hardware design issue for the main serial
> port, a few GPIOs used on the robots that are declared, camera support and
> finally MC13783 support as it is now getting ready.
> 
> For MC13783, we would need RTC as well, but I did not add it yet since it
> is not in mainline yet.
Note I'm currently overhauling mc13783-core.c resulting in an API change.

I plan to add some compatibility stuff, but I'll let you know when I'm
done anyhow.  Are you interested in testing my changes?

I don't know yet if I will try to get the rtc-support into mainline, but
Sasche posted a patch (without feedback) some time ago.  (It's only a
minimal driver, no alarm, no reset detection.)

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
