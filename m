From: george.joseph@fairview5.com (George Joseph)
Date: Sun, 15 Mar 2015 19:25:20 -0600
Subject: Any policy issues with 2 drivers sharing a gpio?
Message-ID: <CAHKv19BivPAUXVN2mq8aYT1rUFRJL+71jFdG4RS-aSf=Fwg0Sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SolidRun Cubox has a recessed button between the HDMI and RJ-45
connectors. The current dts tree does nothing with it but I'd like to
do 2 mutually-exclusive things with it.  First, have gpio-keys expose
it as a button and second, have pps-gpio claim it as a pps input.
Technically not an issue; whichever driver loads first wins.  Before I
submit a patch though, I wanted to make sure they'll be no heartburn
with 2 devices apparently claiming the same gpio.

thanks.
