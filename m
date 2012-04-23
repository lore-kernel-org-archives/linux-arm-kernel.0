From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Mon, 23 Apr 2012 09:27:45 +0200
Subject: device-tree vs gpio-leds gpio_blink_set
Message-ID: <20120423072745.678323582@rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm not yet fully familiar with DT so I thought that adding support for 
device-tree on some kirkwood drivers would help, so I wrote a quick patch
to add device-tree support into kirkwood/orion/... GPIO (patch for rfc
in next mail). Unfortunately, I'm facing a problem that I don't know how
to solve.

The kirkwood/orion gpio have a bit that allows "gpio blinking" (I think
it a square signal but the manual doesn't say it clearly) and it's used
on dns323 and iconnect. When trying to use DT to declare the leds-gpio
stuff, I've noticed that there's no way clearly documented to set the
gpio_blink_set() hook. In fact, it even looks like it's not supported at
all, which seems to be a regression compared to non-DT support.
Does anyone know how to solve that ?

Thanks,
Arnaud
