From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 13 Dec 2017 18:29:12 +0100
Subject: [PATCH 0/2] cpufreq: few fix on mvebu driver
Message-ID: <20171213172914.6148-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The second patch of this series was originally part of the series "Add CPU
Frequency scaling support on Armada 37xx" [1].

As requested by Viresh Kumar, it is extracted in a independent series.
In the meantime, Thomas Petazzoni pointed an issue on the first
version that I fixed in this series.

While I was on this driver I found an aother issue that I fixed with
the first patch.

Thanks,

Gregory

[1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-December/547650.html

Gregory CLEMENT (2):
  cpufreq: mvebu: Free the clock reference in the normal path
  cpufreq: mvebu: Free opp if registering failed

 drivers/cpufreq/mvebu-cpufreq.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

-- 
2.15.1
