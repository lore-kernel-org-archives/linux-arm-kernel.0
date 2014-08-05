From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Tue, 05 Aug 2014 16:48:31 +0200
Subject: [PATCH V2  0/4] ARM: perf: Support i.MX53
Message-ID: <20140805144831.25462.18149.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables hardware performance counters on the i.MX53 SoC

This requires setting registers at both the ARM V7 core level
and the i.MX53 SoC level.

V2: Rework according to suggestions from Will Deacon:
* Make SDER access conditional on DT property
* Use existing runtime PM hooks rather than inventing new ones
