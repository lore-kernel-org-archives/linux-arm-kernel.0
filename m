From: jamie.iles@picochip.com (Jamie Iles)
Date: Tue, 15 Dec 2009 11:15:07 +0000
Subject: ARMv6 performance counters v3
Message-ID: <1260875712-29712-1-git-send-email-jamie.iles@picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Okay, here's the 3rd attempt at support for hardware perf events support
on ARMv6. After feedback from Jean and Will, I've added an arm_pmu
structure that allows other CPU versions to be supported in the future.
At the moment only ARMv6 is supported in hardware.

Thanks to Will and Jean for their comments.
