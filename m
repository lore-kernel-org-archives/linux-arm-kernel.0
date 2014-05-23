From: dinguyen@altera.com (dinguyen at altera.com)
Date: Fri, 23 May 2014 10:16:13 -0500
Subject: [GIT PULL] SOCFPGA DTS updates for 3.16, take 2-version 2
Message-ID: <1400858173-7741-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,

Please consider pulling in these 2 patches for 3.16.

Thanks,

The following changes since commit 8cb289ed60668d3350dda5aa19b4fa1dce1c07f1:

  ARM: socfpga: dts: Add div-reg to the main_pll clocks (2014-05-05 22:33:18 -0500)

are available in the git repository at:

  git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga_dt_updates-for-3.16_take_2_version_2

for you to fetch changes up to a98b60571938ed5cc79992dacb09460f15b6a175:

  ARM: socfpga: dts: add watchdog0+1 (2014-05-22 16:45:31 -0500)

----------------------------------------------------------------
Add the gpio and watchdog dts entries for the SOCFPGA platform.

----------------------------------------------------------------
Sebastian Andrzej Siewior (1):
      ARM: dts: socfpga: add gpio pieces

Steffen Trumtrar (1):
      ARM: socfpga: dts: add watchdog0+1

 arch/arm/boot/dts/socfpga.dtsi |   76 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

________________________________

Confidentiality Notice.
This message may contain information that is confidential or otherwise protected from disclosure. If you are not the intended recipient, you are hereby notified that any use, disclosure, dissemination, distribution, or copying of this message, or any attachments, is strictly prohibited. If you have received this message in error, please advise the sender by reply e-mail, and delete the message and any attachments. Thank you.
