From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 4 Nov 2014 12:30:13 +0000
Subject: [GIT PULL] ARM DT idle states updates
Message-ID: <20141104123013.GA16832@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

please consider pulling the three patches below for 3.19.

First two are updates on idle states bindings and parsing code to add
states descriptions and status property, the last one is just a clean-up
patch, to remove leftovers from the last merge window.

Thanks a lot,
Lorenzo

The following changes since commit 0df1f2487d2f0d04703f142813d53615d62a1da4:

  Linux 3.18-rc3 (2014-11-02 15:01:51 -0800)

are available in the git repository at:

  git://linux-arm.org/linux-2.6-lp.git for-upstream/dt-idle-states-updates

for you to fetch changes up to 6e13873494078ac26862144ca2345546ca905c41:

  drivers: cpuidle: remove cpuidle-arm64 duplicate error messages (2014-11-04 12:09:27 +0000)

----------------------------------------------------------------
Lorenzo Pieralisi (3):
      drivers: cpuidle: add status property to ARM idle states
      drivers: cpuidle: add idle-state-name description to ARM idle states
      drivers: cpuidle: remove cpuidle-arm64 duplicate error messages

 .../devicetree/bindings/arm/idle-states.txt          | 20 ++++++++++++++++++++
 drivers/cpuidle/cpuidle-arm64.c                      | 13 ++-----------
 drivers/cpuidle/dt_idle_states.c                     | 10 +++++++++-
 3 files changed, 31 insertions(+), 12 deletions(-)
