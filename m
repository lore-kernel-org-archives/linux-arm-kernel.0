From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 12 Apr 2015 12:35:54 +0200 (CEST)
Subject: Bug: Wrong gpio polarity for green LED on Olinuxino Maxi
Message-ID: <1546181298.189897.1428834954615.JavaMail.open-xchange@oxbaltgw01.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

i recently discovered that the polarity of the green LED on iMX233-Olinuxino
Maxi (Rev B) is wrong:

# Switches the led off, expected on
echo 255 > /sys/class/leds/green/brightness

# Switches the led on, exptected off
echo 0 > /sys/class/leds/green/brightness

Kernel: 4.0.0-rc4-next-20150320

Unfortunately i don't have any other Olimex board like Mini or Nano.

@Harald: Could you please check it on your boards?

Best regards
Stefan
