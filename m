From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 17 Jan 2013 17:29:17 +0000
Subject: [GIT PULL] clockevents: decouple broadcast mechanism from drivers
Message-ID: <20130117172910.GA10070@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

These are the generic timer patches I posted a few days ago [1], with
the fixes you requested previously.

Please could you pull these into your tree, and create a public branch
for me to base my other patches on?

Thanks,
Mark.

[1] https://lkml.org/lkml/2013/1/14/276

The following changes since commit 9931faca02c604c22335f5a935a501bb2ace6e20:

  Linux 3.8-rc3 (2013-01-09 18:59:55 -0800)

are available in the git repository at:

  git://linux-arm.org/linux-mr.git for-tglx/timer-broadcast

for you to fetch changes up to a9a71292273e2a9ca694ca37aad4b61a3a1fcdee:

  clockevents: Add generic timer broadcast function (2013-01-14 16:55:01 +0000)

----------------------------------------------------------------
Mark Rutland (2):
      clockevents: Add generic timer broadcast receiver
      clockevents: Add generic timer broadcast function

 include/linux/clockchips.h   |  9 +++++++++
 kernel/time/Kconfig          |  4 ++++
 kernel/time/tick-broadcast.c | 28 ++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)
