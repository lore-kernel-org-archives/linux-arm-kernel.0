From: eric@anholt.net (Eric Anholt)
Date: Thu, 25 Feb 2016 14:24:50 -0800
Subject: [PATCH 1/5] ARM: bcm2835: Define standard pinctrl groups in the
 gpio node.
In-Reply-To: <1456425661-26123-2-git-send-email-eric@anholt.net>
References: <1456425661-26123-1-git-send-email-eric@anholt.net>
 <1456425661-26123-2-git-send-email-eric@anholt.net>
Message-ID: <8737sga0nh.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Anholt <eric@anholt.net> writes:

> The BCM2835-ARM-Peripherals.pdf documentation specifies what the
> function selects do for the pins, and there are a bunch of obvious
> groupings to be made.  With these created, we'll be able to replace
> bcm2835-rpi.dtsi's main "set all of these pins to alt0" with
> references to specific groups we want enabled.

Sigh.  The host I've been using for relaying SMTP apparently decided
this week that it doesn't like half my mail.

I'll be off fixing this, so for now if anyone wants to look at the
series it's just in my repo:

https://github.com/anholt/linux/tree/bcm2835-dt-gpio
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160225/b9819c98/attachment.sig>
