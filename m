From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Mon, 17 Dec 2012 12:27:56 +0100
Subject: devicetree support for efikasb
In-Reply-To: <20121217075907.GQ24458@pengutronix.de> (Sascha Hauer's message
 of "Mon, 17 Dec 2012 08:59:07 +0100")
References: <20121217075907.GQ24458@pengutronix.de>
Message-ID: <87licwdikj.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer <s.hauer@pengutronix.de> writes:

> Hi all,

Hi,

>
> I recently put some work into my Efika MX smartbook. Here are patches
> to make it work with a current kernel. It turned out that most of the
> stuff is quite straight forward. Unfortunately there is a lot missing
> in the USB area. Without USB support the Smartbook is pretty much
> useless, so most of the patches are for adding USB support.
>
> What currently works is:
>
> - USB

Is it working or not ? Or you meant that it's working only if you merge
the usbmisc-related for imx5* patches ?

> - Display

Given that you wrote something for the mlt017, do you happen to have a
sii9022 driver too ? :)

> - Battery

I've not noticed something for the ac power supply in the dts. Did I miss something?

> - keyboard/touchpad

Did you try using the white led for 'caps lock' ?

> - Sound (used to work, currently broken)
> - Wifi

How did you enable it ? Did you configure the gpios to always enable it ?

> - LEDs

You're not mentionning pata. Is it working or not ?

>
> I'm not posting the patches here since I do not consider them ready, but
> for everyone interested you can pull the following git tree. I have no
> idea if the patches work together with the preinstalled U-Boot, I use
> barebox on the Smartbook.

I've (very quickly) tested it yesterday and it didn't even boot. I've
yet to look at the serial port output to check if it's a problem on my
side or a bug in the kernel.

>
> Since it's a spare time project I have no schedule when to continue. If
> you want to push this forward, please let me know, I may have soemthing
> newer then.

I'm still interested in getting mainline working on efika devices.

Arnaud
