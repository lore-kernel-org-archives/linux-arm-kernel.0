From: lznuaa@gmail.com (Zhi Li)
Date: Fri, 6 Feb 2015 15:56:27 -0600
Subject: coresignt etm/etb usage
Message-ID: <CAHrpEqR0kPAPCvuFK0XdP9RTojH85xoATt1esbfGTCSPkPu0Tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mathieu:

I try to enable etm/etb in our freescale platform.
I have ported your patches into our tree.
coresign node already created in /sys/devices.

30041000.funnel  31001000.interrupt-controller  platform       software
3007c000.etm     backlight.7                    regulators.10  system
3007d000.etm     breakpoint                     replicator.1   timer.0
30084000.etb     gpio-keys.9                    soc.2          virtual
30087000.tpiu    max7322-reset.8                soc0


But my problem is how to test it.
Do you have document to show how to use it?


best regards
Frank Li
