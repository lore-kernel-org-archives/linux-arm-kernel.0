From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 28 Jan 2016 12:23:47 +0100
Subject: [PATCH v2 0/2] Misc ARM optimizations
Message-ID: <1453980229-5678-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here is a set of two patches that I already sent on March 2015 (first
patch) and June 2015 (second patch).

The first patch hasn't gotten any feedback.

The second patch received some feedback: Russell said he would like
this to be merged at the beginning of a cycle, to give it enough time
for testing. And we are precisely at the beginning of a cycle :-) Rob
Herring had some comments, which I also addressed in a reply.

Would it be possible to either get those patches merged, or a decision
be taken that they are not acceptable, so that I can stop worrying
about them ? :-)

Thanks,

Thomas

Thomas Petazzoni (2):
  ARM: smp_scu: enable coherent speculative linefills
  ARM: mm: enable L1 prefetch on Cortex-A9

 arch/arm/kernel/smp_scu.c | 8 ++++++--
 arch/arm/mm/proc-v7.S     | 5 ++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.6.4
