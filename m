From: eric@anholt.net (Eric Anholt)
Date: Wed, 22 Jul 2015 15:06:55 -0700
Subject: Raspberry Pi 2 interrupt controller support (v3)
Message-ID: <1437602819-17343-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New in this version is a separate compatible value for the 2835's
armctrl as it's used on the 2836, and dropping of some debug printfs
in the 2836 controller.  As before, the full series you can build and
test can be found at:

https://github.com/anholt/linux/tree/bcm2836-irqchip
