From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Tue, 26 Apr 2016 16:53:45 +0200
Subject: [GIT PULL v2] STi DT updates for v4.7 #1
Message-ID: <571F80F9.80901@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider the second version of the first round of STi DT updates 
for v4.7. Problems reported by Olof have been taken into account by Lee.

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/sti.git 
tags/sti-dt-for-v4.7b-1

for you to fetch changes up to 3d90bc051361c6f867df494d838d4fe1215d475a:

   ARM: dts: STi: STih407: Switch LPC mode from RTC to Clocksource 
(2016-04-26 16:10:33 +0200)

----------------------------------------------------------------
Highlights:
-----------
  - Add CPUFreq support to STiH407 family
  - Add Mailbox nodes to STiH407 family
  - Add RemoteProc nodes to STiH407 family
  - Use 'reserved-memory' for DMA memory on STiH407
  - Use the LPC timer as a clocksource

----------------------------------------------------------------
Lee Jones (8):
       ARM: dts: STi: STiH407: Provide generic (safe) DVFS configuration
       ARM: dts: STi: STiH407: Provide CPU with clocking information
       ARM: dts: STi: STiH407: Link CPU with its voltage supply
       ARM: dts: STi: STiH407: Provide CPU with a means to look-up Major 
number
       ARM: dts: STi: stih407-family: Add nodes for Mailbox
       ARM: dts: STiH407: Add nodes for RemoteProc
       ARM: dts: STiH407: Move over to using the 'reserved-memory' API 
for obtaining DMA memory
       ARM: dts: STi: STih407: Switch LPC mode from RTC to Clocksource

  arch/arm/boot/dts/stih407-family.dtsi | 126 
+++++++++++++++++++++++++++++++++-
  1 file changed, 125 insertions(+), 1 deletion(-)
