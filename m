From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 7 Sep 2016 20:09:20 +0200 (CEST)
Subject: [PATCH 1/8] ARM: dts: bcm283x: Define standard pinctrl groups
 in the gpio node.
In-Reply-To: <1473244289-20728-2-git-send-email-kraxel@redhat.com>
References: <1473244289-20728-1-git-send-email-kraxel@redhat.com>
 <1473244289-20728-2-git-send-email-kraxel@redhat.com>
Message-ID: <1564766913.23457.026b1e4b-e35d-48e6-9394-7eeea0ff9add.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gerd,

> Gerd Hoffmann <kraxel@redhat.com> hat am 7. September 2016 um 12:31
> geschrieben:
> 
> 
> From: Eric Anholt <eric@anholt.net>
> 
> The BCM2835-ARM-Peripherals.pdf documentation specifies what the
> function selects do for the pins, and there are a bunch of obvious
> groupings to be made.  With these created, we'll be able to replace
> bcm2835-rpi.dtsi's main "set all of these pins to alt0" with
> references to specific groups we want enabled.

on IMX/MXS platform it's unwanted to add all possible muxes in the dtsi file. So
i would suggest to add only the actually used muxes. That makes it easier to
maintain.

Regards
Stefan
