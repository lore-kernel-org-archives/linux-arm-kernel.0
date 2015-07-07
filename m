From: eric@anholt.net (Eric Anholt)
Date: Tue,  7 Jul 2015 14:13:33 -0700
Subject: Raspberry Pi 2 support, part 1: Interrupt controller
Message-ID: <1436303617-17185-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a little over half of the diff for the Raspberry Pi 2
platform.  A full series you can build and test can be found at:

https://github.com/anholt/linux/tree/bcm2836-irqchip

As you can see looking at that tree, it depends on the rpi-dt-clocks
series, which is still stalled waiting on the rpi-firmware series to
be merged (Lee said he pulled 2/3 of them back on June 5th, but they
haven't appeared in the tree).
