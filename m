From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 14 Jul 2014 10:55:05 +0200
Subject: ARM: Kirkwood: mach-kirkwood's removal
Message-ID: <1405328105.8281.27.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

0) Commit ba364fc752da ("ARM: Kirkwood: Remove mach-kirkwood") is
included in next-20140714. It removes quite a bit of code.

1) The code it removes includes the Kconfig entries for
    ARCH_KIRKWOOD
    MACH_OPENRD_CLIENT
    MACH_OPENRD_ULTIMATE
    MACH_T5325

There are a few references to these Kconfig symbols still left in the
tree. Are patches to remove these references queued somewhere?

2) And is a patch to remove the "arch/arm/mach-kirkwood/" pattern from
MAINTAINERS queued somewhere?

3) By the way, MACH_KIRKWOOD looks related but is not removed in that
commit. That's not an oversight, is it?


Paul Bolle
