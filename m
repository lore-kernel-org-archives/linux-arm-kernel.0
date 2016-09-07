From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 7 Sep 2016 07:55:47 +0200
Subject: [PATCH v5] i2c: imx: make bus recovery through pinctrl optional
In-Reply-To: <CAChUvXOGjTn6K5588UVgjbRWUY+weDtk2qbOU-NM4=kA2znh=Q@mail.gmail.com>
References: <1471644322-22670-1-git-send-email-leoyang.li@nxp.com>
 <20160906185849.27pjhawadca5pwow@pengutronix.de>
 <CADRPPNQ+1qBNL5WA=Jo_keE7BPnoOs7a2T6CpTuciiF16qK6xQ@mail.gmail.com>
 <87ca69fb85848a0a86b34a9a9037a57b@agner.ch>
 <CADRPPNSPye45bmFshfwb+gDA0x0ygs4Ofa6HMYbKt9ER0oeccg@mail.gmail.com>
 <CAChUvXOGjTn6K5588UVgjbRWUY+weDtk2qbOU-NM4=kA2znh=Q@mail.gmail.com>
Message-ID: <20160907055547.opp57zyxhlplhxhm@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Sep 06, 2016 at 06:35:38PM -0500, Tracy Smith wrote:
> >The patch makes it really optional that
> >the probe function won't bailout but just disable the bus recovery function
> >when pinctrl is not available.
> 
> in the case of the LS1043A and LS1021A, if the bus recovery function is
> disabled, how will bus recovery occur?  Is there no option to recover the
> bus for the LS1021a and LS1043a?

Right. That's the situation that we had for all drivers some time ago.
Most of the time this is no problem.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
