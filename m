From: gottfried.haider@gmail.com (Gottfried Haider)
Date: Tue, 18 Oct 2016 22:48:42 +0200
Subject: [PATCH v2] ARM: bcm2835: Add names for the Raspberry Pi GPIO lines
Message-ID: <CAPoCmYLCkth3hisN2YL8SxAFoQ-CVF=NDpogkCY2UVF6RH_pmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric, Linus,

I'll hopefully find time to look at the more recent changes to the
gpio subsystem (lsgpio?!), but since this patch is up for discussion
now - what I was wondering: how does this change relate to
/sys/class/gpio/gpio%d? Is this completely orthogonal - or would this
change the sysfs interface as well?

Regarding the proposed format using the header pin numbers: From what
I've seen in terms of existing educational materials, it seems the
overwhelming majority ends up using GPIO numbers instead of physical
pin header numbering. (e.g. [1] [2])
Would it be too confusing to try to pick GPIO 5 from an alphabetically
sorted list like this "P11_GPIO17", "P12_GPIO18"? (I know,
alphabetical sorting is an issue here already for a different reason.
But applications might do it, I guess?)

Best
Gottfried

[1] https://www.raspberrypi.org/learning/physical-computing-with-python/worksheet/
[2] https://pinout.xyz/pinout/
