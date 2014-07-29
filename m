From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Tue, 29 Jul 2014 14:32:56 +0200
Subject: [PATCH  0/4] ARM: perf: Support i.MX53
Message-ID: <20140729123256.13347.79778.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables hardware performance counters on the i.MX53 SoC

This requires setting registers at both the ARM V7 core level
and the i.MX53 SoC level.
