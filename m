From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 16 Nov 2018 23:43:31 +0100 (CET)
Subject: [PATCH V2 0/3] ARM: dts: add Raspberry Pi 3 A+
In-Reply-To: <87a7m8d8e6.fsf@anholt.net>
References: <1542322805-6211-1-git-send-email-stefan.wahren@i2se.com>
 <87a7m8d8e6.fsf@anholt.net>
Message-ID: <284795801.25939.1542408211398@email.ionos.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

> Eric Anholt <eric@anholt.net> hat am 16. November 2018 um 22:23 geschrieben:
> 
> 
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
> > This patch series adds support for the brand new Raspberry Pi 3 A+ .
> >
> > Changes in V2:
> > - add missing Makefile change for arm64
> >
> > Stefan Wahren (3):
> >   dt-bindings: bcm: Add Raspberry Pi 3 A+
> >   ARM: dts: add Raspberry Pi 3 A+
> >   arm64: dts: broadcom: Add reference to RPi 3 A+
> 
> Looks pretty reasonable, but I couldn't verify any of the contents --
> the firmware repo doesn't have a DT file for it, and the published
> schematics don't show most of the GPIO connections (sigh).  How did you
> write/test this?

i have a Raspberry Pi 3 A+ and the firmware seems to use a runtime generated DT. So i dumped the DTS of a 3 A+ and a 3 B+ from procfs. Based on the procfs diff i modified the upstream 3B+ source to get a 3A+ .

Please consider this series as optional for 5.0. I won't submit any further patch for the next release cycle.

But maybe Phil can provide some feedback.

Regards
Stefan
