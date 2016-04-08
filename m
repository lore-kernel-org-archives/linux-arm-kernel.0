From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Fri, 8 Apr 2016 15:20:50 +0200
Subject: [GIT PULL] STi DT updates for v4.7 #1
Message-ID: <5707B032.60401@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of STi DT updates for v4.7:

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/sti.git 
tags/sti-dt-for-v4.7-1

for you to fetch changes up to a8ff73843d015af1a65e94604677c2efd9ae70d4:

   ARM: STi: DT: STih407: Switch LPC mode from RTC to Clocksource 
(2016-04-05 15:42:29 +0200)

----------------------------------------------------------------
Highlights:
-----------
  - Add CPUFreq support to STiH407 family
  - Add Mailbox nodes to STiH407 family
  - Add RemoteProc nodes to STiH407 family
  - Use 'reserved-memory' for DMA memory on STiH407
  - Use the LPC timer as a clocksource

----------------------------------------------------------------
Lee Jones (9):
       ARM: STi: STiH407: Provide generic (safe) DVFS configuration
       ARM: STi: STiH407: Provide CPU with clocking information
       ARM: STi: STiH407: Link CPU with its voltage supply
       ARM: STi: STiH407: Provide CPU with a means to look-up Major number
       ARM: STi: stih407-family: Add nodes for Mailbox
       ARM: STi: DT: STiH407: Enable Mailbox testing facility
       ARM: STiH407: Add nodes for RemoteProc
       ARM: STiH407: Move over to using the 'reserved-memory' API for 
obtaining DMA memory
       ARM: STi: DT: STih407: Switch LPC mode from RTC to Clocksource

  arch/arm/boot/dts/stih407-family.dtsi | 131 
+++++++++++++++++++++++++++++++++-
  1 file changed, 130 insertions(+), 1 deletion(-)
