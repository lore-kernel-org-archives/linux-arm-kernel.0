From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 10 Aug 2012 14:18:31 +0200
Subject: [PATCH] pinctrl: pinctrl-imx: add imx35 pinctrl driver
In-Reply-To: <CACRpkdaRLFzjq49pd=e7GzPmWuX5C2nWDWZitZV9e6AkHBK4DA@mail.gmail.com>
References: <1343921942-22079-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1344529412-18053-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20120809162742.GG25520@pengutronix.de>
 <CACRpkdaRLFzjq49pd=e7GzPmWuX5C2nWDWZitZV9e6AkHBK4DA@mail.gmail.com>
Message-ID: <20120810121831.GJ25520@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hallo Linus, 

On Fri, Aug 10, 2012 at 01:01:35PM +0200, Linus Walleij wrote:
> On Thu, Aug 9, 2012 at 6:27 PM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> 
> >> +  pull-up for this pin. Please refer to imx53 datasheet for the valid pad
> >
> > argh, I forgot to fix that (ie. s/53/35/). I won't resend just for that.
> > Linus, assuming you intend to take the patch now, can you fix it up
> > while commiting please?
> 
> Sure, but I want an ACK from a Freescale maintainer first ...
I assume you saw the patch has Dong Aisheng's ack, so you want another
one by Shawn or Sascha?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
