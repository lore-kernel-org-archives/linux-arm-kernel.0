From: patrice.chotard@st.com (Patrice Chotard)
Date: Thu, 12 Jan 2017 17:59:43 +0100
Subject: [GIT PULL] STi DT update for v4.11 round 1
Message-ID: <a9026a2a-f5e1-60c3-4e98-0a392d12163d@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof

PLease consider this first round of STi dts update for v4.11 :

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git tags/sti-dt-for-v4.11

for you to fetch changes up to 2016ead446b98c42dffd9b6c03ce813e5cb3b810:

  ARM: dts: STiH407-family: Supply Mailbox properties to delta RProc (2017-01-12 17:23:39 +0100)

----------------------------------------------------------------
STi dts update:

Enable High Quality Video Data Plane (HQVDP) DT entry
Add DELTA V4L2 video decoder DT entry
Disable unused fdma instances
Fix sti-display-subsystem wrong clock parent's value
Cleanup and update DT entries related to remoteproc

----------------------------------------------------------------
Hugues Fruchet (1):
      ARM: dts: STiH410: add DELTA dt node

Patrice Chotard (10):
      ARM: dts: STiH410-B2120: enable sti-hda at board level
      ARM: dts: STiH410: add hqvdp node
      ARM: dts: STiH407-family: disable fdma1 and fdma2
      ARM: dts: STiH410-family: fix wrong parent clock frequency
      ARM: dts: STiH407-family: update gp0_reserved memory region
      ARM: dts: STiH407-family: remove audio remoteproc node
      ARM: dts: STiH407-family: remove gp1 remoteproc node
      ARM: dts: STiH407-family: update dmu remoteproc node
      ARM: dts: STiH407-family: Supply mailbox properties to GP0 RProc
      ARM: dts: STiH407-family: Supply Mailbox properties to delta RProc

 arch/arm/boot/dts/stih407-family.dtsi | 58 ++++++++++-------------------------
 arch/arm/boot/dts/stih410-b2120.dts   |  6 ++++
 arch/arm/boot/dts/stih410.dtsi        | 24 ++++++++++++++-
 3 files changed, 45 insertions(+), 43 deletions(-)
