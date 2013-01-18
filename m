From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 18 Jan 2013 17:15:46 +0000
Subject: [GIT PULL] clockevents: decouple broadcast mechanism from drivers
In-Reply-To: <20130117172910.GA10070@e106331-lin.cambridge.arm.com>
References: <20130117172910.GA10070@e106331-lin.cambridge.arm.com>
Message-ID: <20130118171545.GB15707@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

As has been pointed out elsewhere, in my haste to fix this up I made a
typo in the first patch, preventing it from building.

Apologies for the confusion. I've created a new branch with a corrected
and tested version. Please see the pull request below.

Thanks,
Mark.

The following changes since commit 9931faca02c604c22335f5a935a501bb2ace6e20:

  Linux 3.8-rc3 (2013-01-09 18:59:55 -0800)

are available in the git repository at:

  git://linux-arm.org/linux-mr.git for-tglx/timer-broadcast-v2

for you to fetch changes up to 041d14f475c4436d9fb9a7c94842154c42fd1b65:

  clockevents: Add generic timer broadcast function (2013-01-18 17:07:36 +0000)

----------------------------------------------------------------
Mark Rutland (2):
      clockevents: Add generic timer broadcast receiver
      clockevents: Add generic timer broadcast function

 include/linux/clockchips.h   |  9 +++++++++
 kernel/time/Kconfig          |  4 ++++
 kernel/time/tick-broadcast.c | 28 ++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)
